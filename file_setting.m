function file_setting( action )

global guih

f2save = {'DATDIR', 'STIMDAT', 'TMIN', 'TMAX', 'NSWP', 'SPCfactor', 'TRCfactor', 'SDfactor'};

switch action,
    case 'SAVE',
		for i=1:length(f2save);
			curname = char(f2save(i));
			cmnd = ['setdat.' curname '= get( guih.' curname ',''String'');']
			eval(cmnd);
		end
        save defaultdat setdat
    case 'LOAD',
        load defaultdat
		for i=1:length(f2save);
			curname = char(f2save(i));
			cmnd = ['set( guih.' curname ',''String'' , setdat.' curname ');'];
			eval(cmnd);
		end
        set(guih.STIMLIST,'Value',1);
        set(guih.FILES,'Value',1);
        
        
end