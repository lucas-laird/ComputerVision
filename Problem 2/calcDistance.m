function [distance] = calcDistance(point,H)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pointPrime = H\point';
pointPrime = pointPrime/pointPrime(3);
distance = (sum(sum((pointPrime-point).^2)))^(1/2);
end

