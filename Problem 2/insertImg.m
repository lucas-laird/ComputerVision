function [newPic] = insertImg(destination,insertImage,h)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 2
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz = size(destination);
sz2 = size(insertImage);
newPic = destination;
%Go through the destination image and inverse it. If the inverse of the
%pixel is in the insert image we replace the pixel value at that location.
for k = 1:3
    for i = 1:sz(1)
        for j = 1:sz(2)
            coord = [i;j;1];
            invCoord = h\coord;
            invCoord = invCoord/invCoord(3);
            if(invCoord(1) >= 1 && invCoord(2) >= 1 && invCoord(1) <= sz2(1) && invCoord(2) <= sz2(2))
                newPic(i,j,k) = interpBilinear(invCoord(1:2),insertImage,k);
            end
        end
    end
end
newPic = uint8(newPic);

end

