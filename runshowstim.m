function runshowstim( )

global hfig guih stimlist
global axscale 


hfig = openfig('ShowStimGuiNew4.fig');
guih = guihandles( hfig );

file_setting('LOAD');
stimlist = load_stimlist( hfig, guih);


stimnames = create_list( stimlist );

set( guih.STIMLIST,'String', stimnames);
set( guih.STIMLIST,'Value', 1);
set_files;
axscale(1) = 3;
axscale(2) = 1;
axscale(3) = 5;
set( guih.SPCfactor,'String', num2str( axscale(1)));
set( guih.TRCfactor,'String', num2str( axscale(3)));
set( guih.SDfactor,'String', num2str( axscale(2)));

% % outlistname = get(guih.OUTFILE,'String');
% % if exist(outlistname,'file'),
% %     load(outlistname);
% %     outlist = match_stim2out( stimlist, outlist);
% % else
% %     outlist = reset_outlist( stimlist );
% % end
% % 

