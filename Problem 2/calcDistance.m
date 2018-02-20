function [meanDistance] = calcDistance(points,H)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
distance = zeros(1,10);
for i = 1:10
    p1 = points(:,i,1);
    p2 = points(:,i,2);
    transp2 = H*[p1(1);p1(2);1];
    transp2 = transp2/transp2(3);
    distance(i) = sum((p2-transp2(1:2)).^2)^(1/2);
end
meanDistance = mean(distance);
end

