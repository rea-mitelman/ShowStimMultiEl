function [trcall,rate] = load_data( stimlist, findx2take, indir, tbfr, taft)

global guih SavedClearData


fname = char(stimlist.sess);
disp(fname);
indir = [indir '\' fname '\mat\'];
trc1 = [];
trc2 = [];
rate = [];


for findx = stimlist.files(findx2take),
    trc = [];
    if findx < 10,
        str =['00' num2str(findx)];
    elseif findx < 100,
        str =['0' num2str(findx)];
    else
        str = num2str(findx);
    end;
    lastlet = lower(fname(end));
    if double(lastlet) >= double('0') && double(lastlet) <= double('9'),
        fwvf = [indir fname str '_wvf.mat'];
        fbhv = [indir fname str '_bhv.mat'];
    else
        fwvf = [indir fname(1:end-1) str '_wvf.mat'];
        fbhv = [indir fname(1:end-1) str '_bhv.mat'];
    end
    if ~exist( fwvf,'file') |  ~exist( fbhv,'file');
        disp([ fwvf '  or ' fbhv '  --> no such file']);
        return;
    end;
    wvf = load(fwvf);
    uflag = [0 0];
    
    bhv = load(fbhv);
    if isfield(bhv, 'AMstim'),
        Tstim = bhv.AMstim;
        Trate = bhv.AMstim_KHz;
        
    elseif isfield(bhv, 'AMstim_on'),
        Tstim = bhv.AMstim_on;
        Trate = bhv.AMstim_on_KHz;

    elseif isfield( bhv, 'StimTime'),
        Tstim = bhv.StimTime;
        Trate = bhv.StimTime_KHz;
    else 
        Tstim = 0;
        Trate = 1;
    end
    IxsStim = round(Tstim*Trate*1000);

    
    if ~isempty(IxsStim),
        for el=1:4,
            trcall(el).trc = [];
            if get( guih.SIGLFP,'Value'),
                field1 = ['LFP' num2str(el)];
            else
                field1 = ['Unit' num2str(el)];
			end
			
            if isfield(wvf, field1),
                unit = wvf.(field1);
                rate =  wvf.([field1 '_KHz']);
                uflag(el) =1;
			end
			
			if get(guih.ArtRemFlag,'Value')
				if ~isfield(SavedClearData,fname) 
					SavedClearData.(fname)=cell(0);
				end
				if length(SavedClearData.(fname))<findx || isempty(SavedClearData.(fname){findx})
					SavedClearData.(fname){findx}=cell(4,1);
				end
				if ~isempty(SavedClearData.(fname){findx}{el})
					unit=SavedClearData.(fname){findx}{el};
				else
					us_factor=8; art_end=15; max_dead_time_dur=0.75; do_lin_decay=false;
					unit= remove_artifact_advanced...
						(unit, rate, Tstim, Trate, us_factor, art_end, max_dead_time_dur, do_lin_decay);
					SavedClearData.(fname){findx}{el}=unit;
				end
			
			
			end


            if uflag(el),
                trc =  [];
                s1 = abs(tbfr) * rate;
                s2 = abs(taft)  * rate;
                tmptrc = zeros(length(IxsStim),s2+s1+1);
                Tstim2take = IxsStim( find(IxsStim > s1 & IxsStim  <= length(unit)-s2));
                for ii=1:length(Tstim2take),
                    curs = Tstim2take(ii);
                    tmptrc(ii,:) =unit(curs-s1:curs+s2);
                end;
                trc = [trc;tmptrc];
                trcall(el).trc = trc;
            end
        end
    else
        for el=1:4,
            trcall(el).trc = [];
        end
    end
end

