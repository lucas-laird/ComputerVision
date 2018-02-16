function [points] = GetPoints(pic1,pic2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
points = zeros(2,10,2);
for i = 1:10
    imshow(pic1);
    [x,y] = ginput(1);
    points(1,i,1) = x;
    points(2,i,1) = y;
    imshow(pic2);
    [x,y] = ginput(1);
    points(1,i,2) = x;
    points(2,i,2) = y;
end
end

