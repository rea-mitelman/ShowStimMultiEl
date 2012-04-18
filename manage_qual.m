function manage_qual( action )

global guih

switch action,
    case 'A1',
        set(guih.A1,'Value',1);
        set(guih.B1,'Value',0);
        set(guih.C1,'Value',0);
    case 'B1',
        set(guih.A1,'Value',0);
        set(guih.B1,'Value',1);
        set(guih.C1,'Value',0);
    case 'C1',
        set(guih.A1,'Value',0);
        set(guih.B1,'Value',0);
        set(guih.C1,'Value',1);
    case 'A2',
        set(guih.A2,'Value',1);
        set(guih.B2,'Value',0);
        set(guih.C2,'Value',0);
    case 'B2',
        set(guih.A2,'Value',0);
        set(guih.B2,'Value',1);
        set(guih.C2,'Value',0);
    case 'C2',
        set(guih.A2,'Value',0);
        set(guih.B2,'Value',0);
        set(guih.C2,'Value',1);
end

UpdateGrade;


