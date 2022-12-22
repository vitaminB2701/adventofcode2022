clear;

%% Part 1
f1 = fopen('dat05.txt');
f2 = fopen('dat05_2.txt');
i = 1;
while feof(f1)==0
    dat1 = fgetl(f1);
    stack(i,:) = double(dat1(2:4:end));
    i = i + 1;
end
stack = flipud(stack);
stack(1,:) = [];

dat2 = fscanf(f2,'move %d from %d to %d\n',[3,inf]);
dat2 = dat2';

for i = 1:size(dat2,1)
    src = dat2(i,2);
    des = dat2(i,3);
    for nmove = 1:dat2(i,1)
        h_src = []; h_des = [];
        h_src = find(stack(:,src)==32,1,'first');
        h_des = find(stack(:,des)==32,1,'first');
        while isempty(h_src) || isempty(h_des)
            stack(end+1,:) = 32*ones(size(stack,2),1);
            h_src = find(stack(:,src)==32,1,'first');
            h_des = find(stack(:,des)==32,1,'first');
        end
        [stack(h_des,des),stack(h_src-1,src)] = deal(stack(h_src-1,src),stack(h_des,des));
    end
end
% Read last characters
s = [];
for i = 1:size(stack,2)
    c = find(stack(:,i)==32,1,'first');
    if isempty(c)
        c = size(stack,1)+1;
    end
    s = [s stack(c-1,i)];
end
char(s)
fclose(f1); fclose(f2);

%% Part 2
clear;
f1 = fopen('dat05.txt');
f2 = fopen('dat05_2.txt');
i = 1;
while feof(f1)==0
    dat1 = fgetl(f1);
    stack(i,:) = double(dat1(2:4:end));
    i = i + 1;
end
stack = flipud(stack);
stack(1,:) = [];

dat2 = fscanf(f2,'move %d from %d to %d\n',[3,inf]);
dat2 = dat2';

for i = 1:size(dat2,1)
    src = dat2(i,2);
    des = dat2(i,3);
    Nmove = dat2(i,1);
    h_src = find(stack(:,src)==32,1,'first');
    h_des = find(stack(:,des)==32,1,'first');
    while isempty(h_src) || isempty(h_des)
        stack(end+1,:) = 32*ones(size(stack,2),1);
        h_src = find(stack(:,src)==32,1,'first');
        h_des = find(stack(:,des)==32,1,'first');
    end
    h_max = h_des + Nmove;
    if h_max>size(stack,1)
        stack = [stack; 32*ones(h_max-size(stack,1),size(stack,2))];
    end
    dummy = stack(h_des:h_des+Nmove-1,des);
    stack(h_des:h_des+Nmove-1,des) = stack(h_src-Nmove:h_src-1,src);
    stack(h_src-Nmove:h_src-1,src) = dummy;
end
% Read last characters
s = [];
for i = 1:size(stack,2)
    c = find(stack(:,i)==32,1,'first');
    if isempty(c)
        c = size(stack,1)+1;
    end
    s = [s stack(c-1,i)];
end
char(s)

