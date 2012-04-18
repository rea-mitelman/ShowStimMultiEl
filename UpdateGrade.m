function UpdateGrade( )

global guih stimlist outlist

indx1 = get(guih.STIMLIST,'Value');
indx2 = get(guih.FILES,'Value');
% % el1.Anti = get(guih.ANT1,'Value');
% % el1.Post = get(guih.POST1,'Value');
% % if get(guih.A1,'Value'),
% %     el1.Grd = 1;
% % elseif get(guih.B1,'Value'),
% %     el1.Grd = 2;
% % elseif get(guih.C1,'Value'),
% %     el1.Grd = 3;
% % else
% %     el1.Grd = 0;
% % end
% % el1.Cmnt = get(guih.CMNT1, 'String');
% % el1.ignore = get(guih.IGNORE_EL1,'Value')
% % el2.Anti = get(guih.ANT2,'Value');
% % el2.Post = get(guih.POST2,'Value');
% % if get(guih.A2,'Value'),
% %     el2.Grd = 1;
% % elseif get(guih.B2,'Value'),
% %     el2.Grd = 2;
% % elseif get(guih.C2,'Value'),
% %     el2.Grd = 3;
% % else
% %     el2.Grd = 0;
% % end
% % el2.Cmnt = get(guih.CMNT2, 'String');
% % el2.ignore = get(guih.IGNORE_EL2,'Value')
% % 
outlist(indx1).files(indx2).sess = stimlist(indx1).sess;
outlist(indx1).files(indx2).subsessindx = stimlist(indx1).subsessindx;
outlist(indx1).files(indx2).filenum = stimlist(indx1).files(indx2);
% % outlist(indx1).files(indx2).el1 = el1;
% % outlist(indx1).files(indx2).el2 = el2;
outlist(indx1).files(indx2).config = stimlist(indx1).sess;