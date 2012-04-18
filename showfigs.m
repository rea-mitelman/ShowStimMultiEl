function showfigs( )

flist = dir('*09_*.fig');
for i=1:length(flist),
    curname = char(flist(i).name);
    h = openfig( curname );
    title(curname);
    pause
    close(h);
end
