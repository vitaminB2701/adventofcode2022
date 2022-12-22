clear;
fid = fopen('dat18.txt');
dat = fscanf(fid,'%d,%d,%d',[3, inf]);
dat = dat';
dat = dat + 1;

%% Part 1
[s,dis,sa] = sarea(dat);
g = group(dis);
s

%% Part 2
% Construct a box of air around the droplet
% Subtract the air's surface area to its exterior area (it's just a cubic
% box)
ind22 = @(x,y,z) x*24*24 + y*24 + z;
ind22s = @(x,y) x*24 + y;
xy_drop = ind22s(dat(:,1),dat(:,2));
yz_drop = ind22s(dat(:,2),dat(:,3));
zx_drop = ind22s(dat(:,3),dat(:,1));
ind_drop = ind22(dat(:,1),dat(:,2),dat(:,3));
mindrop = min(dat)-1;
maxdrop = max(dat)+1;
inner_ind = []; air_list = [];
for x = mindrop(1):maxdrop(1)
    for y = mindrop(2):maxdrop(2)
        for z = mindrop(3):maxdrop(3)
            ind_point = ind22(x,y,z);
            if sum(ind_drop==ind_point)==0
                air_list = [air_list; x y z];
                inner_ind = [inner_ind; 0];
                zDrop = dat(xy_drop==ind22s(x,y),3);
                if sum(zDrop>z)>0 && sum(zDrop<z)>0
                    xDrop = dat(yz_drop==ind22s(y,z),1);
                    if sum(xDrop>x)>0 && sum(xDrop<x)>0
                        yDrop = dat(zx_drop==ind22s(z,x),2);
                        if sum(yDrop>y)>0 && sum(yDrop<y)>0
                            inner_ind(end) = 1;
                        end
                    end
                end
            end
        end
    end
end
inner_ind = logical(inner_ind);
inner_list = air_list(inner_ind,:);
[~,dis_air] = sarea(air_list); g_air = group(dis_air);
ex_list = air_list(g_air==1,:);
s_ex = sarea(ex_list);
edge = maxdrop-mindrop+1;
s_ex - 2*(edge(1)*edge(2) + edge(2)*edge(3) + edge(3)*edge(1))

%%
function [s,dis,sa] = sarea(dat)
N = size(dat,1);
dat3_1(:,1,:) = dat;
dat3_2(1,:,:) = dat;
dis = sum(abs(dat3_1-dat3_2),3);
dis(dis~=1) = 0;
dis = squeeze(dis);
sa = 6*ones(1,N);
sa = sa - sum(dis);
s = sum(sa);
end

function g = group(dis)
N = length(dis);
dis = dis + eye(N);
g = 1:N;
check = 1;
while check==1
    check = 0;
    for i = 1:N
        connection = logical(dis(:,i));
        if any(g(connection)~=min(g(connection)))
            g(connection) = min(g(connection));
            check = 1;
        end
    end
end
end