function runbatch_stim( monkey, stimlist )

N2PLOT = 15;
tbfr = -50;
taft = 250;
hfigp = figure;
noiseflg =1;

for i=1:length(stimlist),
    sess = char(stimlist(i).sess);
    disp(sess);
    for j=1:length(stimlist(i).files),
        [fwvf, fbhv] = compose_fname( monkey, sess, stimlist(i).files(j));
        [trc1, trc2,trc3, rate] = load_data( fwvf, fbhv, tbfr, taft);
        if ~isempty(trc1) || ~isempty(trc2) || ~isempty(trc3),
            plot_singlesess( trc1, trc2, trc3, rate, tbfr, taft, hfigp, N2PLOT, noiseflg,char(stimlist(i).config ));
            pause
            clf;
        end
    end
end

end

function [wvf, bhv] = compose_fname( monkey, sess, j)

switch lower(monkey),
    case 'hugo',
        indir = ['\hugo\hugodata\' sess '\mat\'];
    case 'vega',
        indir = ['\vega\data\' sess '\mat\'];
end

if j < 10,
    str = '00';
elseif j< 100,
    str = '0';
else
    str = '';
end
str = [str num2str(j)];
wvf = [indir sess str '_wvf.mat'];
bhv = [indir sess str '_bhv.mat'];
end

function  [trc1, trc2, trc3,rate] = load_data( fwvf, fbhv, tbfr, taft)
    
wvf = load(fwvf);
uflag = [0 0 0];
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
if isfield(wvf, 'Unit3'),
    unit3 = wvf.Unit3;
    rate(3) =  wvf.Unit3_KHz;
    uflag(3) =1;
end;

bhv = load(fbhv);
if isfield(bhv, 'AMstim'),
    Tstim = bhv.AMstim;
    Trate = bhv.AMstim_KHz;
else
    Tstim = bhv.StimTime;
    Trate = bhv.StimTime_KHz;
end
Tstim = round(Tstim*Trate*1000);
for j=1:3,
    if uflag(j) && ~isempty(Tstim),
        trc =  [];
        cmnd = ['unit = unit' num2str(j) ';'];
        eval(cmnd);
        s1 = abs(tbfr) * rate(j);
        s2 = abs(taft)  * rate(j);
        tmptrc = zeros(length(Tstim),s2+s1+1);
        Tstim = Tstim( find(Tstim > s1 & Tstim  <= length(unit)-s2));
        for ii=1:length(Tstim),
            curs = Tstim(ii);
            tmptrc(ii,:) =unit(curs-s1:curs+s2);
        end;
        trc = [trc;tmptrc];
        cmnd = ['trc' num2str(j) '=trc;'];
        eval(cmnd);
    else
        cmnd = ['trc' num2str(j) '=[];'];
        eval(cmnd);
    end
end
end

function plot_singlesess( trc1, trc2, trc3, rate, tbfr, taft, hfigp, N2PLOT, noiseflg,ttl);

filtflag = 0;

axscale(1) = 1;
axscale(3) = 5;
axscale(2) = 5;

figure(hfigp);
set(hfigp,'Units','normalized');

AX2 = axes('Position',[0.1 0.1 0.25 0.2]);
AX4 = axes('Position',[0.4 0.1 0.25 0.2]);
AX6 = axes('Position',[0.7 0.1 0.25 0.2]);
AX1 = axes('Position',[0.1 0.35 0.25 0.6]);
AX3 = axes('Position',[0.4 0.35 0.25 0.6]);
AX5 = axes('Position',[0.7 0.35 0.25 0.6]);
for j=1:3,
    cmnd = ['trc = trc' num2str(j) ';'];
    eval(cmnd);
    if j==1,
        axtop = AX1;
        axbot = AX2;
    elseif j==2,
        axtop = AX3;
        axbot = AX4;
    elseif j==3,
        axtop = AX5;
        axbot = AX6;
    end
    if ~isempty(trc),
        mn = mean(trc);
        trcOrg = trc;
        if noiseflg,
            ysum = sum(abs(trcOrg'));
            ym = median(ysum);
            ystd = mad(ysum);
            indx2take = find(ysum < ym+2*ystd & sum(ysum) ~= 0 & ysum > (ym-2*ystd));
            trcOrg = trcOrg(indx2take,:);
            
        end
        if filtflag,
            for r=1:size(trcOrg,1),
                tmp = trcOrg(r,:);
                tmp = iirfiltfilt(tmp, rate(1) * 1000, 6000, 500);
                trcOrg(r,:) = tmp';
            end
        end
        
 
  
        s1 = abs(tbfr) * rate(j);
        s2 = abs(taft)  * rate(j);
        ax = (-s1:s2)/rate(j);              
        axes( axtop);
        Lng = min(N2PLOT, size(trcOrg,1));
        r = rand(size(trcOrg,1),1);
        [r,indx]=sort(r);
        indx = sort(indx(1:Lng));
        for ii=1:Lng,
            %     y = abs(trcOrg(indx(i),:));
            y(ii,:) = (trcOrg(indx(ii),:));
            y(ii,:) = y(ii,:)*axscale(3)+ii*axscale(1);
        end
        plot(ax,y');
        axis tight
        if j==1,
            title(ttl);
        end
        % %             set(guih.AX1,'XLim',[tbfr taft]);
        % %             set(guih.AX1,'YLim',[0 max(y)]);
        
        %             axis([ax(1) ax(end) 0 max(y)]);
        %             title([fname '-' sesslist(i).config ', file: ' num2str(findx) ', ch.' num2str(j)])
        %
        axes( axbot);
        ibase = find(ax >= -10 & ax <= -4);
        ipost = find(ax>= 2 & ax <= 8);
        ypre = mean(abs(trcOrg(:,ibase))');
        ypost = mean(abs(trcOrg(:,ipost))');
        %                 [p,h]=ranksum(ypre,ypost);
        y = mean(abs(trcOrg));
        mbase = mean(y(ibase));
        sdbase = std(y(ibase));
        o = ones(size(ax));
        plot(ax,y, ax, o*mbase,'r', ax,o*(mbase+sdbase*2),'r:')
        axis([ax(1) ax(end) min(y) mbase+10*axscale(2)*sdbase]);
        
        set(axtop,'FontSize', 6);
        set(axbot,'FontSize', 6);
        set(axtop,'TickDir', 'out');
        set(axbot,'TickDir', 'out');

    else
        axes(axtop);cla;
        axes(axbot);cla;
    end
end
end
