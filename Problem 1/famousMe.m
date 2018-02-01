function [out_img] = famousMe(in_img,ins_img,x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz = size(ins_img);
out_img = in_img;
%Cut out the section that the inserted image might cover.
kernel = in_img(x:x+sz(1), y:y+sz(2),:);
%Create a mask of the inserted image
mask = binaryMask(ins_img);
%Get locations of pixels to replace
[xInd,yInd] = find(mask == 1);
%Replace pixels in kernel
for i = 1:length(xInd)
    kernel(xInd(i),yInd(i),:) = ins_img(xInd(i),yInd(i),:);
end
%Put kernel into out image.
out_img(x:x+sz(1), y:y+sz(2),:) = kernel;
end

