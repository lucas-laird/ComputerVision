function [pix] = interpBilinear(coord,image,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 2
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Interp Bilinear from hw 1
row = floor(coord(1));
col = floor(coord(2));
m = coord(1)-row;
n = coord(2)-col;
if(m == 0 && n == 0)
    pix = image(row,col,k);
else
    pix = (1-m)*(1-n)*image(row,col,k) + (1-m)*n*image(row,col+1,k) + m*(1-n)*image(row+1,col,k)+m*n*image(row+1,col+1,k);
end
end

