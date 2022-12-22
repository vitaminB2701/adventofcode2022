clear;
fid = fopen('dat1.txt');
f = fscanf(fid,'Sensor at x=%d, y=%d: closest beacon is at x=%d, y=%d\n');
f = reshape(f,[4,length(f)/4])';
Sx = f(:,1); Sy = f(:,2);
Bx = f(:,3); By = f(:,4);
dis = abs(Sx-Bx) + abs(Sy-By);
parpool('local', 8);
M = 4e6;
tic
parfor y0 = 2e6:4e6
    disy = dis - abs(Sy-y0);
    corx = [];
    for i = 1:length(disy)
        if disy(i)>=0
            corx = [corx; [Sx(i)-disy(i) Sx(i)+disy(i)]];
        end
    end
    corx(corx<0) = 0; corx(corx>M) = M;
    a = corx(:,1) - corx(:,2)';
    a(a~=2) = 0;
    if sum(sum(a))~=0 || min(min(corx))~=0 || max(max(corx))~=M
        icorx = corx +1;
        liney = zeros(1,M+1);
        for i = 1:size(corx,1)
            liney(icorx(i,1):icorx(i,2)) = 1;
        end
        if(sum(liney)<M+1)
			format long
            find(liney==0)-1
			y0
        end
    end
end
toc;
fclose(fid);