clear;
fid = fopen('dat03.txt');
dat = readlines('dat03.txt');
sum = 0;
for i = 1:length(dat)
    s = dat(i);
    s = double(convertStringsToChars(s));
    s1 = s(1:length(s)/2);
    s2 = s(length(s)/2+1:end);
    a = intersect(s1,s2);
    if a>=97
        a = a - 96;
    else
        a = a - 64 + 26;
    end
    sum = sum + a;
end

%%
sum = 0;
for i = 1:3:length(dat)
    s1 = double(convertStringsToChars(dat(i)));
    s2 = double(convertStringsToChars(dat(i+1)));
    s3 = double(convertStringsToChars(dat(i+2)));
    a = intersect(intersect(s1,s2),s3);
    if a>=97
        a = a - 96;
    else
        a = a - 64 + 26;
    end
    sum = sum + a;
end