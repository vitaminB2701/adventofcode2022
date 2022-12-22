% Load 
f = fopen('dat04.txt');
dat = fscanf(f,'%d-%d, %d-%d\n');
dat = reshape(dat,4,length(dat)/4)';

% Find containing pairs
cnt = 0;
for i = 1:size(dat,1)
    if (dat(i,1)>=dat(i,3) && dat(i,2)<=dat(i,4)) || (dat(i,1)<=dat(i,3) && dat(i,2)>=dat(i,4))
        cnt = cnt + 1;
    end
end

% Find overlapping pairs
cnt2 = 0;
for i = 1:size(dat,1)
    if dat(i,2)>=dat(i,3) && dat(i,1)<=dat(i,4)
        cnt2 = cnt2 + 1;
    end
end