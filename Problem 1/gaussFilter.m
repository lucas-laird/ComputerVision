function [out_img] = gaussFilter(in_img,sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    kernelSize = 2*ceil(2*sigma)+1;
    buffer = ceil((kernelSize-1)/2); %Calculate buffer size from kernel size
    nm = size(in_img);
    tempImg = padarray(in_img, [buffer, buffer],nan,'both'); %Pad the array
    out_img = in_img;
    for k = 1:3
        for i = 1:nm(1)
            for j = 1:nm(2)
                kernel = tempImg(i:i+2*buffer, j:j+2*buffer, k); %Get kernel
                a = 0;
                    for n = 1:2*buffer
                        for m = 1:2*buffer
                            %%For every pixel in the kernel, add it to the 
                            %%running total and weight it using the
                            %%gaussian distribution.
                            x = abs(buffer-n+1);
                            y = abs(buffer-m+1);
                            G = (1/(2*pi*sigma^2))*exp(-1*(x^2+y^2)/(2*sigma^2));
                            a = a+G*double(kernel(n,m)); 
                        end
                    end
                out_img(i,j,k) = uint8(a);
            end
        end
    end
end