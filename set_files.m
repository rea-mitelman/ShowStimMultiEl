function set_files( )

global hfig guih stimlist

indx = get(guih.STIMLIST,'Value');

if isempty(stimlist),
    return
end
for j=1:length(stimlist(indx).files),
    flist{j} = num2str(stimlist(indx).files(j));
end;

set(guih.FILES,'String',flist);
set(guih.FILES,'Value',1);