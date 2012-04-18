function sessout = FindStimFiles( parentdir )

fdir = dir([parentdir '\h*']);
fdir = sortdirs( fdir );
indx =1;
sessout = [];
for i=1:length(fdir),
    cursess = char(fdir(i));
    disp(cursess);
    if isdir([parentdir '\' cursess '\info']),
        dat = load([parentdir '\' cursess '\info\' cursess '_param.mat']);
        for j=1:length(dat.SESSparam.SubSess),
            if isfield(dat.SESSparam.SubSess(j), 'GlobalStim') & ~isempty(dat.SESSparam.SubSess(j).GlobalStim),
                cmntR = lower(char(dat.SESSparam.SubSess(j).GlobalStim.Text));
            else
                cmntR = '';
            end
            if findstr(cmntR, 'stim'),
                disp(cmntR);
            end
            if findstr(cmntR,'stim') & isempty(findstr(cmntR, 'dbs')),
                [e, cnfig]=getfilenums(cmntR);
            else
                e=0;
            end
            if e > 0,
                sessout(indx).sess = cursess;
                sessout(indx).subsessindx = j;
                sessout(indx).files = e;
                sessout(indx).config = cnfig;
                indx = indx+1;
            end
        end
    end
end  
function fout = sortdirs( fin)

j = 1;
for i=1:length(fin),
    if fin(i).isdir 
        curdir = char(fin(i).name);
        indx(j,3) = str2num(curdir(2:3));
        indx(j,2) = str2num(curdir(4:5));        
        indx(j,1) = str2num(curdir(6:7));
        fout(j) = {curdir};
        j = j+1;
    end
end

[indx, i] = sortrows(indx);
fout = fout(i);

function [e, cnfig]=getfilenums(cmnt)

disp(cmnt);
e=[];
e1=0;
e2=0;
cnfig = '';
posall = findstr(cmnt,'-');
if isempty(posall),
    disp('single or no files specified');
    pos =1;
    pos1 = 0;
    pos2 = 0;
    while pos <= length(cmnt),
        if double(cmnt(pos)) >= double('0') && double(cmnt(pos)) <= double('9'),
            pos1 = pos;
            pos2 = pos1;
            pos = length(cmnt)+1;
        else
            pos = pos+1;
        end
    end
    if pos1,
        pos = pos1;
        while pos <= length(cmnt),
            if double(cmnt(pos)) >= double('0') && double(cmnt(pos)) <= double('9'),
                pos2 = pos;
                pos = pos+1;
            else
                pos = length(cmnt)+1;
            end
        end
        e1 = str2num(cmnt(pos1:pos2));
        e2 = e1;
        disp(e1);
        disp(e2);
        e=[e e1:e2];
        disp(e);
        %         pause
    end
    return
end

for pos=posall,
    if isempty(findstr(cmnt(1:pos),' ')),
        pos1 = 1;
    else
        pos1 = max(findstr(cmnt(1:pos),' '));
    end
    e1 = str2num(cmnt(pos1:pos-1));
    if isempty(findstr(cmnt(pos+1:end),' ')),
        pos1 = length(cmnt);
    else
        pos1 = min(findstr(cmnt(pos+1:end),' '))+pos;
    end
    e2 = str2num(cmnt(pos+1:pos1));
    disp(e1);
    disp(e2);
    e=[e e1:e2];
    disp(e);
    cnfig = cmnt;
end



