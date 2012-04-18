function SaveDat( )

global outlist guih

outlistname = get(guih.OUTFILE,'String');

save( outlistname, 'outlist');





