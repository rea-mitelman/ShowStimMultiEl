function show_singlesess( trcall, rate, tbfr, taft, hfig, N2PLOT, noiseflg, stim_times, stim_Fs);

global guih

axscale(1) = str2double(get( guih.SPCfactor,'String'));
axscale(3) = str2double(get( guih.TRCfactor,'String'));
axscale(2) = str2double(get( guih.SDfactor,'String'));

filtflag = get(guih.FILTERFLAG,'Value');
figure(hfig);

if isempty(rate),
    rate = 1;
end
for j=1:4,
    trc = trcall(j).trc;
    cmnd = ['axtop = guih.MX' num2str(j)];
    eval(cmnd);
    cmnd = ['axbot = guih.SX' num2str(j)];
    eval(cmnd);

    s1 = abs(tbfr) * rate;
    s2 = abs(taft)  * rate;
    ax = (-s1:s2)/rate(1);
    axes( axtop);
 
    if ~isempty(trc),
        if size(trc,1) > 1,
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
                if get(guih.SIGUNIT,'Value'), % this is a plot of single units
                    for r=1:size(trcOrg,1),
                        tmp = trcOrg(r,:);
                        tmp = iirfiltfilt(tmp, rate(1) * 1000, 6000, 500);
                        trcOrg(r,:) = tmp';
                    end
                else
                    for r=1:size(trcOrg,1),
                        tmp = trcOrg(r,:);
                        tmp = iirfiltfilt(tmp, rate(1) * 1000, 100, 5);
                        trcOrg(r,:) = tmp';
                    end
                end
            end

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
            set(axtop,'FontSize', 5);
            axis tight
            % %             set(guih.AX1,'XLim',[tbfr taft]);
            % %             set(guih.AX1,'YLim',[0 max(y)]);
            
            %             axis([ax(1) ax(end) 0 max(y)]);
            %             title([fname '-' sesslist(i).config ', file: ' num2str(findx) ', ch.' num2str(j)])
            %
            axes( axbot);
            ibase = find(ax >= -10 & ax <= -4);
            ipost = find(ax>= 2 & ax <= 8);
			if get(guih.AbsFlag,'Value'),
				ypre = mean(abs(trcOrg(:,ibase))');
				ypost = mean(abs(trcOrg(:,ipost))');
				%                 [p,h]=ranksum(ypre,ypost);
				y = mean(abs(trcOrg));
				mbase = mean(y(ibase));
				sdbase = std(y(ibase));
			else
				ypre = mean((trcOrg(:,ibase))');
				ypost = mean((trcOrg(:,ipost))');
				%                 [p,h]=ranksum(ypre,ypost);
				y = mean((trcOrg));
				mbase = mean(y(ibase));
				sdbase = std(y(ibase));
			end
            o = ones(size(ax));
            plot(ax,y, ax, o*mbase,'r', ax,o*(mbase+sdbase*2),'r:')
            axis([ax(1) ax(end) mbase-10*axscale(2)*sdbase mbase+10*axscale(2)*sdbase]);  
        else
            y = trc;
            y = y*axscale(3);
                        plot(ax,y');
            set(axtop,'FontSize', 5);
            axis tight
            axes( axbot);cla
        end
    else
        axes(axtop);cla;
        axes(axbot);cla;
        % %         cmnd = ['set(guih.IGNORE_EL' num2str(j) ',''Value'',1);'];
        % %         eval(cmnd);
    end
end

