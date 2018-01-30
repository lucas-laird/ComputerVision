function [out_img] = funFilter(in_img,theta,ox,oy)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    sz = size(in_img);
    unitMat = [cosd(theta),-1*sind(theta); sind(theta), cosd(theta)];
    
    
end