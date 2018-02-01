function [out_img] = scaleNearest(in_img,factor)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sz = size(in_img);
    %Get the size of the new scaled image
    sx = round(sz(1)*factor);
    %pre-allocate the image space
    out_img = zeros(sz(2),sx,3);
    %Scaling Matrix, use to invert coordinates
    scaleMat = [1,0;0,factor];
    for i = 1:sz(2)
        for j = 1:sx
            for k = 1:3
                %Invert the coordinates
                invCoord = inv(scaleMat)*[i;j];
                %Find nearest coordinate on old image and replace with the
                %pixel value at that location
                pix = findNearest(in_img,invCoord,k);
                out_img(i,j,k) = pix;
            end
        end
    end
    out_img = uint8(out_img);
        
end

