function browse( action )

global hfig guih stimlist outlist

switch (action),
    case 'STIMDIR',
        [fnm, pth] = uigetfile( '*.mat', 'Select a stim list MAT file');
        if isempty(fnm) | fnm == 0,
            return
        else
            set( guih.STIMDAT,'string', [pth '\' fnm]);
            stimlist = load_stimlist( hfig, guih);
            stimnames = create_list( stimlist );
            set( guih.STIMLIST,'String', stimnames);
            set( guih.STIMLIST,'Value', 1);
            set_files;           
            outlist = match_stim2out( stimlist, outlist);
        end
    case 'OUTDIR',
        [fnm, pth] = uigetfile( '*.mat', 'Select a output MAT file');
        if isempty(fnm) | fnm == 0,
            return
        else
            outlistname = [pth '\' fnm];
            set( guih.OUTFILE,'string', [pth '\' fnm]);
            load(outlistname);
            outlist = match_stim2out( stimlist, outlist);
        end
        
    case 'DATADIR',
        pth = uigetdir;
        if isempty(pth),
            return;
        else
            pth = [pth '\'];
            set( guih.DATDIR, 'string', pth);
        end
end