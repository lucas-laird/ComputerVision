function [out_img] = meanFilter(in_img,kernelSize)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    buffer = ceil((kernelSize-1)/2); %Buffer size based on kernel size
    nm = size(in_img); %Size of the image
    tempImg = padarray(in_img, [buffer, buffer],nan,'both'); %Padarray
    for k = 1:3
        for i = 1:nm(1)
            for j = 1:nm(2)
                kernel = tempImg(i:i+2*buffer, j:j+2*buffer, k); %get the kernel
                m = mean(mean(kernel(kernel ~= 0),'omitnan')); %Find average value of kernel
                out_img(i,j,k) = uint8(m); %Make values uint8
            end
        end
    end
end

