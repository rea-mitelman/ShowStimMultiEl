function stimnames = create_list( stimlist )

stimnames =[];

for i=1:length(stimlist),
    stimnames{i} = [stimlist(i).sess '-' num2str(stimlist(i).subsessindx)];
end
