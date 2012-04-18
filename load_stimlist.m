function stimdat = load_stimlist( hfig, guih)

fnm = get( guih.STIMDAT,'string');

fnm = char(fnm);
if exist( fnm, 'file'),
    load(fnm);
else
    disp([fnm '--> no such file']);
    stimdat = [];
    return;
end
stimdat = sessout;
