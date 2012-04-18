function     outlist = reset_outlist( stimlist )

for i=1:length(stimlist),
    files = stimlist(i).files(1):stimlist(i).files(end);
    for j=1:length(files),
        outlist(i).files(j).sess = stimlist(i).sess;
        outlist(i).files(j).subsessindx = stimlist(i).subsessindx;
        outlist(i).files(j).j = files(j);
        outlist(i).files(j).el1 = [];
        outlist(i).files(j).el2 = [];
        outlist(i).files(j).config = stimlist(i).config;
    end
end