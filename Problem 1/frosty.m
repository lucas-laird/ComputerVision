function [out_img] = frosty(in_img,n,m)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    tempImg = padarray(in_img,[floor(n/2),floor(m/2)],NaN);
    sz = size(in_img);
    for k = 1:sz(3)
        for i = 1:sz(1)
            for j = 1:sz(2)
               kernel = tempImg(i:i+2*floor(n/2),j:j+2*floor(m/2),k);
               val = datasample(kernel(kernel ~= 0), 1);
               out_img(i,j,k) = val;
            end
        end
    end
end

