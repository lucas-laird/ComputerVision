function [newPic] = mosaic(rightImage,leftImage,points,h)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 2
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Calculate the warped image size.
sz = size(rightImage);
corners = [1,1,1;sz(1),1,1;1,sz(2),1;sz(1),sz(2),1]';

mapcorners = h*corners;
mapcorners(1,:) = mapcorners(1,:)./mapcorners(3,:);
mapcorners(2,:) = mapcorners(2,:)./mapcorners(3,:);
maxX = max(mapcorners(1,:));
maxY = max(mapcorners(2,:));
minX = min(mapcorners(1,:));
minY = min(mapcorners(2,:));

Tx = -minX;
Ty = -minY;

%Find the location of the point in the warped image.
%Gets the homography warp of the image
matchPoint1 = h*[points(1,1,1);points(2,1,1);1];
matchPoint1 = matchPoint1/matchPoint1(3);
%Now shift it again
matchPoint1(1) = matchPoint1(1)+Tx;
matchPoint1(2) = matchPoint1(2)+ Ty;

%%Shift amount to align the points
rowShift = floor(points(1,1,2)-matchPoint1(1));
colShift = floor(abs(points(2,1,2)-matchPoint1(2)));

newPic = zeros(1,1);
sz = size(leftImage);

%%If the rowShift is < 0 we instead shift the left image up
if(rowShift < 0)
    for k = 1:3
        for i = 1:sz(1)
            for j = 1:sz(2)
                newPic(i-rowShift,j,k) = leftImage(i,j,k);
            end
        end
    end
    %Insert the warped image where it should be
    sz = size(rightImage);
    for k = 1:3
        for i = 1:maxX+Tx
            for j = 1:maxY+Ty
                coord = [i-Tx,j-Ty,1]';
                invCoord = h\coord;
                invCoord = invCoord/invCoord(3);
                if(invCoord(1) >= 1 && invCoord(2) >= 1 && invCoord(1) <= sz(1) && invCoord(2) <= sz(2))
                    newPic(i,j+colShift,k) = interpBilinear(invCoord(1:2),rightImage,k);
                end
            end
        end
    end
else
    %Otherwise we shift the right image down
    sz = size(rightImage);
    newPic = leftImage;
    for k = 1:3
        for i = 1:maxX+Tx
            for j = 1:maxY+Ty
                coord = [i-Tx,j-Ty,1]';
                invCoord = h\coord;
                invCoord = invCoord/invCoord(3);
                if(invCoord(1) >= 1 && invCoord(2) >= 1 && invCoord(1) <= sz(1) && invCoord(2) <= sz(2))
                    newPic(i+rowShift,j+colShift,k) = interpBilinear(invCoord(1:2),rightImage,k);
                end
            end
        end
    end
end




newPic = uint8(newPic);
end

