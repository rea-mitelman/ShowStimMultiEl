function countresponse( )

load outstim_yifat.mat

L = length(outlist);
for i=1:L,
    for j=1:length(outlist(i).files),
        for e=1:2,
            str = ['el' num2str(e)];
            tmp = outlist(i).files(j).(str);
            if ~isempty(tmp) && ~isfield(tmp,'ignore'),
                disp([outlist(i).files(j).sess '- electrode:' num2str(j)]);
            end
        end
    end
end


sesscnt = zeros(1,2);
prevsess = '';
for i=1:L,
    cnts = zeros(1,2);
    for j=1:length(outlist(i).files),
        for e=1:2,
            str = ['el' num2str(e)];
            if isfield(outlist(i).files(j),str),
                tmp = outlist(i).files(j).(str);
                if ~isempty(tmp) && ~isfield(tmp,'ignore'),
                    disp([outlist(i).files(j).sess '- electrode:' num2str(j)]);
                elseif ~isempty(tmp) && ~tmp.ignore,
                    cnts(e) =cnts(e)+1;
                end
            end
        end
    end
    sesscnt = sesscnt+(sign(cnts));
end

bar(sesscnt)
disp(sesscnt);


cntsAall = zeros(1,2);
cntsPall = zeros(1,2);
for i=1:L,
    cntsA = zeros(1,2);
    cntsP = zeros(1,2);

    for j=1:length(outlist(i).files),
        for e=1:2,
            str = ['el' num2str(e)];
            if isfield(outlist(i).files(j),str),
                tmp = outlist(i).files(j).(str);
                if ~isempty(tmp) && ~isfield(tmp,'ignore'),
                    disp([outlist(i).files(j).sess '- electrode:' num2str(j)]);
                elseif ~isempty(tmp) && ~tmp.ignore,
                    if tmp.Anti && tmp.Grd <= 2,
                        cntsA(e) =cntsA(e)+1;
                    elseif tmp.Post,
                        cntsP(e) =cntsP(e)+1;
                    end
                end
            end
        end
    end
    cntsAall = cntsAall + sign(cntsA);
    cntsPall = cntsPall + sign(cntsP);
end

disp(cntsAall);
disp(cntsPall);
