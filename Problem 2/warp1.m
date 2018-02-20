function [warpPic] = warp1(pic1,h)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 2
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Get the size of the image by checking the minimum and maximum rows and
%columns
sz = size(pic1);
corners = [1,1,1;sz(1),1,1;1,sz(2),1;sz(1),sz(2),1]';

mapcorners = h*corners;
mapcorners(1,:) = mapcorners(1,:)./mapcorners(3,:);
mapcorners(2,:) = mapcorners(2,:)./mapcorners(3,:);
maxX = max(mapcorners(1,:));
maxY = max(mapcorners(2,:));
minX = min(mapcorners(1,:));
minY = min(mapcorners(2,:));

%Shift amount so that if there are negative values for the mapped corners,
%they become 1. 
Tx = -minX;
Ty = -minY;

warpPic = zeros(floor(maxX+Tx),floor(maxY+Ty),3);
%Inverse transform to get the value
for k = 1:3
    for i = 1:maxX+Tx
        for j = 1:maxY+Ty
            coord = [i-Tx,j-Ty,1]';
            invCoord = h\coord;
            invCoord = invCoord/invCoord(3);
            if(invCoord(1) < 1 || invCoord(2) < 1)
                warpPic(i,j,k) = 0;
            elseif(invCoord(1) > sz(1) || invCoord(2) > sz(2))
                warpPic(i,j,k) = 0;
            else
                warpPic(i,j,k) = interpBilinear(invCoord(1:2),pic1,k);
            end
            
        end
    end
end
warpPic = uint8(warpPic);
end

