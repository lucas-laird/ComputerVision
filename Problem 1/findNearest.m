function [pix] = findNearest(in_img,coord,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sz = size(in_img);
    x = 1:sz(1);
    y = 1:sz(2);
    %Minimize distance in x and y direction separately, geting the x and y
    %coordinate location by doing so.
    [we,minX] = min(abs(x-coord(1)));
    [we,minY] = min(abs(y-coord(2)));
    %Return pixel value at that location.
    pix = in_img(minX,minY,k);
    
end
