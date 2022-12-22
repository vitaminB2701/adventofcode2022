clear;

% Read data
dat = readcell('dat16.txt');
N = length(dat);
for n = 1:N
    s1 = dat{n,1}; s2 = dat{n,2};
    valveName(n,:) = double(s1(7:8));
    valveRate(n) = str2num(s1(strfind(s1,'=')+1:end));
    comma = strfind(s2,',');
    lead = zeros(length(comma)+1,2);
    if isempty(comma)
        lead = s2(end-1:end);
    else
        lead(1,:) = s2(end-1:end);
        for i = 1:length(comma)
            lead(i+1,:) = s2(comma(i)-2:comma(i)-1);
        end
    end
    leadTo{n} = lead(:,1)*100 + lead(:,2);
    leadNo(n) = size(lead,1);
end
valveList = valveName(:,1)*100+valveName(:,2);

% connection
K = zeros(N);
for n = 1:N
    K(ind(valveList,leadTo{n}),n) = 1;
end
% K = K + diag(valveRate~=0);

% Shortest connection
valveWork = valveRate(valveRate~=0);
short = zeros(length(valveRate));
for j = 1:length(valveRate)
    if valveRate(j)~=0
        for i = j+1:length(valveRate)
            if valveRate(i)~=0
                sumK = K(:,j);
                cnt = 1;
                while sumK(i)==0
                    sumK = sum(K(:,sumK~=0),2);
                    cnt = cnt + 1;
                end
                short(i,j) = cnt;
            end
        end
    end
end
short = short + short';
% short = short(valveRate~=0,valveRate~=0);

%%
pathList = perms(1:14);
pos0 = 22;
pos1 = find(K(:,pos0)==1);
pathStart = pathList(:,1);
pathList = pathList(logical(sum(pathStart==pos1',2)),:);
score = zeros(size(pathList,1),1);
for i = 1:size(pathList,1)
    pth = pathList(i,:);
    timeleft = 28;
    for nv = 1:length(pth)-1
        score(i) = score(i) + valveRate(pth(nv))*timeleft;
        timeleft = timeleft - short(pth(nv+1),pth(nv)) - 1;
    end
    score(i) = score(i) + valveRate(pth(end))*timeleft;
end
[a,b] = max(score)
%% swarming
pop = 1000000;
T = 30;
bestScore = 0;
bestRate = 0;
for npop = 1:pop
    pos = 1;
    rate = 0;
    score = 0;
    Kcon = K;
    for nT = 1:T
        score = score + rate;
        go = find(Kcon(:,pos)==1);
%         if Kcon(pos,pos)==1
%             go = [go; pos*ones(5,1)];
%         else
        for i = 1:length(go)
            go = [go; go(i)*ones(valveRate(go(i))-1,1)];
        end
%         end
        pos2 = go(randi(length(go)));
        if pos2==pos
            rate = rate + valveRate(pos);
            Kcon(pos,pos) = 0;
        end
        pos = pos2;        
    end
    if score>bestScore
        bestScore = score;
        bestRate = rate;
    end
%     if rate>bestRate
%         bestRate = rate;
%     end
end

