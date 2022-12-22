clear;
dat = load('test20.txt');
N = length(dat);
dat0 = dat;
dat = [dat zeros(size(dat))];
for nmix = 1
    dat(:,2) = 0;
for i = 1:N
    index = find(dat(:,2)==0,1,'first');
    step = dat(index,1);
    index2 = index + step;
    if index2<0
%         index2 = index2+floor(index2/N);
        index2 = mod(index2,N-1);
    elseif index2>N
%         index2 = index2+floor(index2/N);
        index2 = mod(index2,N-1);
    else
        index2 = mod(index2,N); % circular array
    end
    if index2==0 
        dat(index,:) = [];
        dat = [dat; step 1];
    elseif index2==1
        dat(index,:) = [];
        dat = [step 1; dat];
    elseif index2==2 && index==1
        dat(index,:) = [];
        dat = [dat(1,:); step 1; dat(2:end,:)];
    elseif index2<index
        dat(index,:) = [];
        dat = [dat(1:index2-1,:); step 1; dat(index2:end,:)];
    elseif index2>index
        dat(index,:) = [];
        dat = [dat(1:index2-1,:); step 1; dat(index2:end,:)];
    else
        dat(index,2) = 1;
    end
end
end
% Find number 0 and coordinates
index0 = find(dat(:,1)==0,1,'first');
coor1 = dat(mod(index0+1000,N-1),1);
coor2 = dat(mod(index0+2000,N-1),1);
coor3 = dat(mod(index0+3000,N-1),1);
coor1+coor2+coor3
