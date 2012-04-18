function scaleaxis( action )

global guih

tmp1 = str2double(get( guih.SPCfactor,'String'));
tmp3 = str2double(get( guih.TRCfactor,'String'));
tmp2 = str2double(get( guih.SDfactor,'String'));


switch action,
    case '1',
        tmp1 = tmp1+.1;
    case '2',
        tmp1 = tmp1-.1;
        tmp1 = max(0.001,tmp1);
    case '3',
        tmp2 = tmp2+.1;
    case '4',
       tmp2 = tmp2-.1;
       tmp2 = max(0.001,tmp2);
     
end

set( guih.SPCfactor,'String', num2str( tmp1));
set( guih.TRCfactor,'String', num2str( tmp3));
set( guih.SDfactor,'String', num2str( tmp2));

show_stimsess