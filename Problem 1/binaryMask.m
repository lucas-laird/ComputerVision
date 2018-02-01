function [mask] = binaryMask(in_img)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grayscale image
    grayImage = 0.299*in_img(:,:,1)+0.587*in_img(:,:,2)+0.114*in_img(:,:,3);
    sz = size(grayImage);
    mask = zeros(sz(1),sz(2));
    %Cut out areas where the image is too bright since wrench is darker
    %than the grey background. Would change value and maybe go from < to >
    %if the inserted image were lighter than its background.
    ind = find(grayImage < 140);
    %Set value = 1 indicating that we want to use these pixels
    mask(ind) = 1;
end

