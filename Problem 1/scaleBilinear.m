function [out_img] = scaleBilinear(in_img,factor)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sz = size(in_img);
    %Get new size of the scaled image
    sx = round(sz(1)*factor);
    sy = round(sz(2)*factor);
    out_img = zeros(sy,sx,3);
    %Scaling matrix, used to invert coordinates
    scaleMat = [factor,0;0,factor];
    for i = 1:sy
        for j = 1:sx
            for k = 1:3
                %Invert coordinates to find original coordinates in in_img
                invCoord = scaleMat\[i;j];
                %Interpolate pixel value
                pix = findBilinear(in_img,invCoord,k);
                out_img(i,j,k) = pix;
            end
        end
    end
    out_img = uint8(out_img);
        
end

