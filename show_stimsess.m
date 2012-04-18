function show_stimsess( action )

global hfig guih stimlist trcall rate outlist

indx = get(guih.STIMLIST,'Value');
indir = get(guih.DATDIR,'String');
tbfr = str2num(get(guih.TMIN,'String'));
taft = str2num(get(guih.TMAX,'String'));
N2PLOT = str2num(get(guih.NSWP,'String'));
findx = get(guih.FILES,'Value');
noiseflag = get(guih.RMVNOISE,'Value');


if nargin,
    switch( action )
        case 'RELOAD',
            [trcall, rate] = load_data( stimlist(indx), findx, indir, tbfr, taft);
    end
end

    
show_singlesess( trcall, rate, tbfr, taft, hfig,N2PLOT, noiseflag);
% ShowGrading

% % if ~isempty(outlist(indx).files(findx).el1),
% %     set(guih.ANT1,'Value',outlist(indx).files(findx).el1.Anti );
% %     set(guih.POST1,'Value',outlist(indx).files(findx).el1.Post );
% %     set(guih.A1,'Value',0);
% %     set(guih.B1,'Value',0);
% %     set(guih.C1,'Value',0);
% %     switch( outlist(indx).files(findx).el1.Grd),
% %         case 1,
% %             set(guih.A1,'Value',1);
% %         case 2,
% %             set(guih.B1,'Value',1);
% %         case 3,
% %             set(guih.C1,'Value',1);
% %     end
% %     set(guih.CMNT1, 'String', outlist(indx).files(findx).el1.Cmnt);
% %     if ~isfield( outlist(indx).files(findx).el1,'ignore'),
% %         outlist(indx).files(findx).el1.ignore = 0;
% %     end   
% %     if isempty(trc1),
% %         set(guih.IGNORE_EL1,'Value',1);
% %         outlist(indx).files(findx).el1.ignore = 1;
% %     else, 
% %         set(guih.IGNORE_EL1, 'Value', outlist(indx).files(findx).el1.ignore);
% %     end
% % else
% %     ResetDat;
% % end
% %             
% % if ~isempty(outlist(indx).files(findx).el2),
% %     set(guih.ANT2,'Value',outlist(indx).files(findx).el2.Anti );
% %     set(guih.POST2,'Value',outlist(indx).files(findx).el2.Post );
% %     set(guih.A2,'Value',0);
% %     set(guih.B2,'Value',0);
% %     set(guih.C2,'Value',0);
% %     switch( outlist(indx).files(findx).el2.Grd),
% %         case 1,
% %             set(guih.A2,'Value',1);
% %         case 2,
% %             set(guih.B2,'Value',1);
% %         case 3,
% %             set(guih.C2,'Value',1);
% %     end
% %     set(guih.CMNT2, 'String', outlist(indx).files(findx).el2.Cmnt);
% %     if ~isfield( outlist(indx).files(findx).el2,'ignore'),
% %         outlist(indx).files(findx).el2.ignore = 0;
% %     end
% %     
% %     if isempty(trc2),
% %         set(guih.IGNORE_EL2,'Value',1);
% %         outlist(indx).files(findx).el2.ignore = 1;
% %     else, 
% %         set(guih.IGNORE_EL2, 'Value', outlist(indx).files(findx).el2.ignore);
% %     end
% % 
% % else
% %     ResetDat;
% % end
% % 
% % disable_plot('EL1');
% % disable_plot('EL2');

          


    
