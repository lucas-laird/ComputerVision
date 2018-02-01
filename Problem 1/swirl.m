function [out_img] = swirl(in_img,ox,oy,factor)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out_img = in_img;
sz = size(in_img);
for k = 1:3
    for i = 1:sz(1)
        for j = 1:sz(2)
            %Retrieve out image coordinates but shift so that the origin is
            %at the center (0,0) point
            currCoord = [i-ox;j-oy];
            %Get the radial Distance from the origin
            r = sum(currCoord.^2)^(1/2);
            %Scale theta by how far it is from the origin
            theta = factor*(r/10);
            %rotation matrix for scaled theta. Use to invert coordinates
            transMat = [cosd(theta),-1*sind(theta);sind(theta), cosd(theta)];
            %Invert the coordinates and interpolate using nearest neighbor
            newCoord = transMat\currCoord;
            %Remove origin offset so it maps onto the original image
            %correctly.
            newCoord(1) = newCoord(1)+ox;
            newCoord(2) = newCoord(2)+oy;
            %Interpolate
            pix = findNearest(in_img,newCoord,k);
            out_img(i,j,k) = pix;
        end
    end
end
end

