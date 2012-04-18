function print_singlesess( trc1, trc2, rate, tbfr, taft, hfigp, N2PLOT, noiseflg);

global guih trcall
filtflag = get(guih.FILTERFLAG,'Value');

axscale(1) = str2double(get( guih.SPCfactor,'String'));
axscale(3) = str2double(get( guih.TRCfactor,'String'));
axscale(2) = str2double(get( guih.SDfactor,'String'));

figure(hfigp);
set(hfigp,'Units','normalized');

AX2 = axes('Position',[0.1 0.1 0.4 0.2]);
AX4 = axes('Position',[0.55 0.1 0.4 0.2]);
AX1 = axes('Position',[0.1 0.35 0.4 0.6]);
AX3 = axes('Position',[0.55 0.35 0.4 0.6]);
for j=1:2,
    cmnd = ['trc = trc' num2str(j) ';'];
    eval(cmnd);
    if j==1,
        axtop = AX1;
        axbot = AX2;
    else
        axtop = AX3;
        axbot = AX4;
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

