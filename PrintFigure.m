function PrintFigure( )

global hfig guih stimlist trc1 trc2 rate trcall

htmp = figure;
if ~isempty(trcall(1)) || ~isempty(trcall(2))  || ~isempty(trcall(4))  || ~isempty(trcall(4)) 
    tbfr = str2num(get(guih.TMIN,'String'));
    taft = str2num(get(guih.TMAX,'String'));
    N2PLOT = str2num(get(guih.NSWP,'String'));
    findx = get(guih.FILES,'Value');
    sindx = get(guih.STIMLIST,'Value');
    noiseflag = get(guih.RMVNOISE,'Value');
    
    print_singlesess( trc1, trc2, rate, tbfr, taft, htmp,N2PLOT, noiseflag);
end

% orient(htmp,'landscape');
% saveas(htmp, 'tmp.eps', 'psc2');
% pause
% close(htmp);
% printdlg(hfig);


% % orient(hfig,'landscape');
% % print(hfig, '-noui', '-depsc','tmp.eps');