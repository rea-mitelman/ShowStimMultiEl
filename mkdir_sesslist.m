function elout = mkdir_sesslist( indat )

elout = zeros(200,3);

for i=1:length(indat),
    for j=1:length(indat(i).files),
        if ~isempty(indat(i).files(j).el1),
            %             if indat(i).files(j).el1.Anti & indat(i).files(j).el1.Grd <= 2,
            if indat(i).files(j).el1.Post %& indat(i).files(j).el1.Grd <= 3,
                id = getid(char(indat(i).files(j).sess));
                elout(id,1)=id;
                elout(id,2) = 1;
            end
            %             if indat(i).files(j).el2.Anti & indat(i).files(j).el2.Grd  <= 2,
            if indat(i).files(j).el2.Post %& indat(i).files(j).el2.Grd <= 2,
                id = getid(char(indat(i).files(j).sess));
                elout(id,1)=id;
                elout(id,3) = 1;
            end
        end
    end
end

elout = elout(find(elout(:,1)),:);


function id = getid(sess)

load(['e:\hugo\hugodata\' sess '\info\' sess '_param.mat']);
id = DDFparam.ID;

