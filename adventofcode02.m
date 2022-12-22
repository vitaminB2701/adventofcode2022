
fid = fopen('dat02.txt');
dat = fscanf(fid,'%c %c\n');

%% Part 1
abc = double(dat(1:2:end))-64;
xyz = double(dat(2:2:end))-87;
game = xyz-abc;
game(game==-2) = 1;
game(game==2) = -1;
game(game==0) = 3;
game(game==1) = 6;
game(game==-1) = 0;
sum(game)+sum(xyz)

%% Part 2
game = double(dat(2:2:end))-89;
xyz = game + abc;
xyz(xyz==4) = 1;
xyz(xyz==0) = 3;
sum((game+1)*3)+sum(xyz)
