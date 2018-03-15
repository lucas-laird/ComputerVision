function disparity = stereoDP(e1,e2,maxDisp,occ)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 3
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initialize initial conditions
e1 = double(e1);
e2 = double(e2);
D = zeros(numel(e1),numel(e2));
sz = size(maxDisp);
for i = 1:numel(e1)
    D(1,i) = i*occ;
end
for i = 1:numel(e2)
    D(i,1) = i*occ;
end
Direc = cell(numel(e1),numel(e2));
D(2,2) = (e1(1)-e2(1))^2;

%Generate solution for the matrix
for i = 2:numel(e1)
    for j = 2:numel(e2)
        if ~(i == 2 && j == 2)
            vec = [D(i-1,j-1)+(e1(i)-e2(j))^2, D(i-1,j)+occ, D(i,j-1)+occ];
            [D(i,j),Ind] = min(vec);
            if(Ind == 1)
                Direc{i,j} = 'D';
            elseif(Ind ==2)
                Direc{i,j} = 'N';
            else
                Direc{i,j} = 'W';
            end
        end
    end
end
disparity = [];
i = numel(e1);
j = numel(e2);
%Backtrack down to find each match or occlusion
while(i ~= 2 && j ~= 2)
    direction = Direc{i,j};
    switch direction
        case 'D'
            %Pixel i matches to pixel j
            disparity(i) = i-j;
            i = i-1;
            j = j-1;
        case 'N'
            %Pixel i is occluded
            disparity(i) = NaN;
            i = i-1;
        case 'W'
            %Pixel j is occluded
            j = j-1;
    end
end
end

