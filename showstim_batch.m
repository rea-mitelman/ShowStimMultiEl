function showstim_batch( sesslist )

odir = '\hugo\stimout\'
for i=1:length(sesslist),
    fname = char(sesslist(i).sess);
    disp(fname);
    indir = ['\hugo\hugodata\' fname '\mat\'];
    tbfr = -50; % time in ms
    taft = 250;
%     N2PLOT =10;
%     figure(1);
    dout = [];
    outname = [odir fname '_' num2str(sesslist(i).subsessindx) '.mat'];
    if 0, %exist(outname, 'file'),
        disp([outname ' file exists. Skipping']);
    else    
        disp(['Adding a session --> ' outname]);
        for findx = sesslist(i).files,
            trc = [];
            [wvf, bhv] = load_mat_files( indir, fname, findx );
            [unit1, unit2, rate, uflag] = get_unit_dat( wvf );
            [Tstim, Trate] = get_stim_data( bhv );
            TrainFlag = test_rate( Tstim );
            Tstim = round(Tstim*Trate*1000);
            curindx = findx-sesslist(i).files(1)+1;
            if ~TrainFlag,
                for j=1:2,
                    if uflag(j) & ~isempty(Tstim),
                        trc =  [];
                        cmnd = ['unit = unit' num2str(j) ';'];
                        eval(cmnd);
                        s1 = abs(tbfr) * rate(j);
                        s2 = abs(taft)  * rate(j);
                        trc = zeros(length(Tstim),s2+s1+1);
                        Tstim = Tstim( find(Tstim > s1 & Tstim  <= length(unit)-s2));
                        for ii=1:length(Tstim),
                            curs = Tstim(ii);
                            tmp = unit(curs-s1:curs+s2);
                            tmp = iirfiltfilt(tmp, rate(1) * 1000, 6000, 500);
                            trc(ii,:) = tmp';
                        end;
                        
                        ysum = sum(abs(trc'));
                        ym = median(ysum);
                        ystd = mad(ysum);
                        indx2take = find(ysum < ym+2*ystd & sum(ysum) ~= 0 & ysum > (ym-2*ystd));
                        trc = trc(indx2take,:);
                        
                        s1 = abs(tbfr) * rate(1);
                        s2 = abs(taft)  * rate(1);
                        ax = (-s1:s2)/rate(1);
                        
                        dout(curindx).sess = fname;
                        dout(curindx).subsess = sesslist(i).subsessindx;
                        dout(curindx).rate_khz = rate(j);
                        dout(curindx).time_ms = -[tbfr taft];
                        dout(curindx).ax = ax;
                        dout(curindx).file = findx;
                        dout(curindx).trc(j).dat = trc;
                    else
                        dout(curindx).trc(j).dat = [];
                    end
                end
            end
        end
        
        % now  taking some pre-stim responses. The baseline level is common
        % for all stimulation ampltiudes!
        prefile = sesslist(i).files(1)-1;
        if prefile >= 1,
            [blwvf, blbhv] = load_mat_files( indir, fname, prefile );
            [unit1, unit2, rate, uflag] = get_unit_dat( blwvf );
            for j=1:2,
                if uflag(j),
                    bsln =  [];
                    cmnd = ['unit = unit' num2str(j) ';'];
                    eval(cmnd);
                    s1 = abs(tbfr) * rate(j);
                    s2 = abs(taft)  * rate(j);
                    Lmax = s2+s1+1;
                    L = length(unit);
                    irow = floor(L/Lmax);
                    tmp = unit(1:Lmax*irow);
                    tmp = iirfiltfilt(tmp, rate(1) * 1000, 6000, 500);
                    bsln = reshape(tmp, irow,Lmax);
                    unitbsln(j).dat = bsln;
                end
            end
        end
        outname = [odir fname '_' num2str(sesslist(i).subsessindx) '.mat'];
        save(outname,'dout', 'unitbsln');
    end
end
%             title(['Average of channel ' num2str(chnl) ' N = ' num2str(size(trc,1)) ', P=' num2str(p)]);
% subplot 212;
% plot(ax,std(trc));


function [wvf, bhv] = load_mat_files( indir, fname, findx )

wvf = [];
bhv = [];

if findx < 10,
    str =['00' num2str(findx)];
elseif findx < 100,
    str =['0' num2str(findx)];
else
    str = num2str(findx);
end;
fwvf = [indir fname str '_wvf.mat'];
fbhv = [indir fname str '_bhv.mat'];
if ~exist( fwvf,'file') |  ~exist( fbhv,'file');
    disp([ fwvf '  or ' fbhv '  --> no such file']);
    return;
end;
wvf = load(fwvf);
bhv = load(fbhv);

        
function TrainFlag = test_rate( Tstim )

frq = 1/median(diff(Tstim));
if frq > 0 & frq < 1.5,
    TrainFlag =1;
    disp('This is a train');
end
disp(['StimFrq  = ' num2str(frq)]);
if isempty(frq) || isnan(frq),
    disp('no Tstim'),
    TrainFlag = -1,
elseif frq > 5,
   TrainFlag =1;
   disp('This is a train');
else
    TrainFlag = 0;
end
    

        
    

function [unit1, unit2, rate, uflag] = get_unit_dat( wvf )
uflag = [0 0];
unit1 = [];
unit2 = [];
rate = [0 0];
if isfield(wvf, 'Unit1'),
    unit1 = wvf.Unit1;
    rate(1) =  wvf.Unit1_KHz;
    uflag(1) =1;
end
if isfield(wvf, 'Unit2'),
    unit2 = wvf.Unit2;
    rate(2) =  wvf.Unit2_KHz;
    uflag(2) =1;
end;


function [Tstim, Trate] = get_stim_data( bhv )

Tstim = 0;
Trate = 0;
if isfield(bhv, 'AMstim'),
    Tstim = bhv.AMstim;
    Trate = bhv.AMstim_KHz;
else
    Tstim = bhv.StimTime;
    Trate = bhv.StimTime_KHz;
end
