function disable_plot( action )


global  hfig guih 

UpdateGrade;

return

switch( action ),
    
    case 'EL1',
        if get(guih.IGNORE_EL1,'Value');
            set(guih.AX1,'Color',[.5 .5 .5]);
            set(guih.AX2,'Color',[.5 .5 .5]);
        else
            set(guih.AX1,'Color',[1 1 1]);
            set(guih.AX2,'Color',[1 1 1]);
        end
    case 'EL1',
        if get(guih.IGNORE_EL2,'Value');
            set(guih.AX3,'Color',[.5 .5 .5]);
            set(guih.AX4,'Color',[.5 .5 .5]);
        else           
            set(guih.AX3,'Color',[1 1 1]);
            set(guih.AX4,'Color',[1 1 1]);
       end

end

