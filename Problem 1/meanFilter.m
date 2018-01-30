function [out_img] = meanFilter(in_img,kernelSize)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    buffer = ceil((kernelSize-1)/2);
    nm = size(in_img);
    tempImg = padarray(in_img, [buffer, buffer],nan,'both');
    for k = 1:3
        for i = 1:nm(1)
            for j = 1:nm(2)
                kernel = tempImg(i:i+2*buffer, j:j+2*buffer, k);
                m = mean(mean(kernel(kernel ~= 0),'omitnan'));
                out_img(i,j,k) = uint8(m);
            end
        end
    end
end

