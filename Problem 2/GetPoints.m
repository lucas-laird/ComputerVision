function [points] = GetPoints(pic1,pic2,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 2
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
points = zeros(2,10,2);
%just use ginput to get points and store them
for i = 1:n
    imshow(pic1);
    [x,y] = ginput(1);
    points(1,i,1) = y;
    points(2,i,1) = x;
    imshow(pic2);
    [x,y] = ginput(1);
    points(1,i,2) = y;
    points(2,i,2) = x;
end
end

