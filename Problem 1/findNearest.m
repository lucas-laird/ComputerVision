function [pix] = findNearest(in_img,coord,k)
    sz = size(in_img);
    y = 1:sz(1);
    x = 1:sz(2);
    xInd = repmat(x,2,sz(1));
    yInd = repmat(y,1,sz(2));
    diffX = abs(xInd-coord(1));
    diffY = abs(yInd-coord(2));
    diffTot = diffX+diffY;
    [M,I] = min(diffTot(:));
    [i,j] = ind2sub(size(in_img),I);
    pix = in_img(i,j,k);
    
end
