function [pix] = findBilinear(in_img,coord,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sz = size(in_img);
    %Inverted coordinate values
    x = coord(1);
    y = coord(2);
    %Nearest defined points
    x1 = floor(x);
    x2 = ceil(x);
    y1 = floor(y);
    y2 = ceil(y);
    
    %If we land outside of the image, cannot interpolate, instead just use
    %nearest neighbor
   if(x1 == 0 || y1 == 0 || x2 > sz(1) || y2 > sz(2))
       pix = findNearest(in_img,coord,k);
   %If we land on row/column, use linear interpolation
   elseif(x1 == x2 && y1 == y2)
       %If we land exactly on a pixel, no need to interpolate
       pix = in_img(x1,y1,k);
   elseif(x1 == x2)
       %Interpolate in y direction since x direction is defined.
       pix = (in_img(x1,y2,k)-in_img(x1,y1,k))*(y-y1)+in_img(x1,y1,k);
   elseif(y1 == y2)
       %Interpolate in x direction since y direction is defined.
       pix = (in_img(x2,y1,k)-in_img(x1,y1,k))*(x-x1)+in_img(x1,y1,k);
   else
       %Bilinearly interpolate since neither direction is defined.
       f11 = in_img(x1,y1,k);
       f12 = in_img(x1,y2,k);
       f21 = in_img(x2,y1,k);
       f22 = in_img(x2,y2,k);
       %Use the interpolation matrix algorithm.
       mat = [1, x1, y1, x1*y1;...
              1, x1, y2, x1*y2;...
              1, x2, y1, x2*y1;...
              1, x2, y2, x2*y2];
       vec = [1;x;y;x*y];
       avec = inv(mat)'*vec;
       pix = avec(1)*f11+avec(2)*f12+avec(3)*f21+avec(4)*f22;
   end
           
               
    
end
