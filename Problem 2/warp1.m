function [warpPic] = warp1(pic,h)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
warpPic = zeros(1,1,3);
[rowN,colM,rgb] = size(pic);
for k = 1:rgb
    for i = 1:rowN
        for j = 1:colM
            currPoint = [i;j;1];
            newPoint = h\currPoint;
            newPoint = newPoint/newPoint(3);
            newCoord = newPoint(1:2);
            warpPic(newCoord(1),newCoord(2),k) = pic(i,j,k);
        end
    end
end
end

