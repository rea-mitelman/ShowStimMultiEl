function showstim( fname, e1, e2, chnl )

indir = ['d:\hugodata\' fname '\mat\'];
tbfr = 10; % time in ms
taft = 10;
N2PLOT =50;
clf
trc = [];
for indx = e1:e2,
    if indx < 10,
        str =['00' num2str(indx)];
    elseif indx < 100,
        str =['0' num2str(indx)];
    else 
        str = num2str(indx);
    end;

    fwvf = [indir fname str '_wvf.mat'];
    fbhv = [indir fname str '_bhv.mat'];
    if ~exist( fwvf,'file') |  ~exist( fbhv,'file');
        disp([ fwvf '  or ' fbhv '  --> no such file']);
        return;
    end;
    wvf = load(fwvf);
    if chnl == 1,
        unit = wvf.Unit1;
        rate =  wvf.Unit1_KHz;
    elseif chnl == 2,
        unit = wvf.Unit2;
        rate =  wvf.Unit2_KHz;
    elseif chnl == 3,
        unit = wvf.Unit3;
        rate  =  wvf.Unit3_KHz;
    end;
    bhv = load(fbhv);
    Tstim = bhv.StimTime;
    Trate = bhv.StimTime_KHz;

    s1 = abs(tbfr) * rate;
    s2 = abs(taft)  * rate;
    
    tmptrc = zeros(length(Tstim),s2+s1+1);
    
    Tstim = round(Tstim*Trate*1000);
    Tstim = Tstim( find(Tstim > s1 & Tstim  <= length(unit)-s2));
    for i=1:length(Tstim),
        curs = Tstim(i);
        tmptrc(i,:) =unit(curs-s1:curs+s2);
    end;
    trc = [trc;tmptrc];
       

end;

mn = mean(trc);
trcOrg = trc;

for i=1:size(trc,1),
   %  trc(i,:) = trc(i,:) - mn;
    trc(i,:) = iirfiltfilt( trc(i,:), rate * 1000, 1000, 6000);
end

ax = (-s1:s2)/rate;

clf
% subplot 221
figure(1)
hold on
m = mean(mean(trc));
Lng = min(N2PLOT, size(trc,1));
r = rand(Lng,1);
[r,indx]=sort(r);
indx = sort(indx);
for i=1:Lng,
    y = abs(trc(indx(i),:));
     y = y+i/5;
    plot(ax,y);
end
hold off
% subplot 222
figure(2)
cla
hold on
for i=1:Lng,
    %     y = abs(trcOrg(indx(i),:));
    y = (trcOrg(indx(i),:));
     y = y+i/4;
    plot(ax,y);
end
hold off


% subplot 223
figure(3)
cla
ibase = find(ax >= -10 & ax <= -4);
ipost = find(ax>= 2 & ax <= 8);
ypre = mean(abs(trc(:,ibase))');
ypost = mean(abs(trc(:,ipost))');
[p,h]=ranksum(ypre,ypost);
y = mean(abs(trc));
mbase = mean(y(ibase));
sdbase = std(y(ibase));
o = ones(size(ax));
plot(ax,y, ax, o*mbase,'r', ax,o*(mbase+sdbase*2),'r:')
axis([ax(1) ax(end) min(y) mbase+100*sdbase]);
title(['Average of channel ' num2str(chnl) ' N = ' num2str(size(trc,1)) ', P=' num2str(p)]);
% subplot 212;
% plot(ax,std(trc));



        
    

        
    

