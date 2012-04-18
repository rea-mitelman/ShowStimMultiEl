function set_signal( action ),

global guih
switch action,
    case 'LFP',
        set (guih.SIGUNIT, 'Value', 0);
        set (guih.SIGLFP, 'Value', 1);
    case 'UNIT',
        set (guih.SIGUNIT, 'Value', 1);
        set (guih.SIGLFP, 'Value', 0);
end
