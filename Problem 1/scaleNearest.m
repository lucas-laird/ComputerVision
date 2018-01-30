function [out_img] = scaleNearest(in_img,factor)
    sz = size(in_img);
    sx = sz(1)*factor;
    out_img = zeros(sx,sz(2),3);
    scaleMat = [factor,0;0,1];
    for i = 1:sx
        for j = 1:sz(2)
            for k = 1:3
                invCoord = inv(scaleMat)*[i;j];
                pix = findNearest(in_img,invCoord,k);
                out_img(i,j,k) = pix;
            end
        end
    end
    out_img = uint8(out_img);
        
end

