function   newlistout = match_stim2out( stimlist, outlist);

% newlistout = reset_outlist( stimlist );

if length(outlist) ~= length(stimlist),
    warndlg('Mismatching output and stimlist. Adjusting lists!','Warning!!');
    for i=1:length(stimlist),
        cursess = char(stimlist(i).sess);
        cursub = stimlist(i).subsessindx;
        pos = findsess( outlist, cursess, cursub);
        if ~isempty(pos),
            newlistout(i).files = outlist(pos).files;
        else
            files = stimlist(i).files(1):stimlist(i).files(end);
            for j=1:length(files),
                newlistout(i).files(j).sess = stimlist(i).sess;
                newlistout(i).files(j).subsessindx = stimlist(i).subsessindx;
                newlistout(i).files(j).j = files(j);
                newlistout(i).files(j).el1 = [];
                newlistout(i).files(j).el2 = [];
                newlistout(i).files(j).config = stimlist(i).config;
            end
        end

    end
else
    newlistout = outlist;
end
disp('here')

function  pos = findsess( outlist, cursess, cursub)

pos = [];
indx = 1;
while indx <= length(outlist),
    outsess = char(outlist(indx).files(1).sess);
    outsub = char(outlist(indx).files(1).subsessindx);
    if strcmp(outsess, cursess) && (outsub == cursub),
        pos = indx;
        return;
    else
        indx=indx+1;
    end
end

    
