function PrintFigure( )

global hfig guih stimlist trc1 trc2 rate 

htmp = figure;
if ~isempty(trc1) || ~isempty(trc2),
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