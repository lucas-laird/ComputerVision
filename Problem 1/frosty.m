function [out_img] = frosty(in_img,n,m)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sz = size(in_img);
    %%Choose a random x and random y. These represent the coordinates of
    %%the pixel chosen inside of the kernel
    ranX = randi(n,sz(1),sz(2));
    ranY = randi(m,sz(1),sz(2));
    ranX = ranX-floor(n/2);
    ranY = ranY-floor(m/2);
    for k = 1:3
        for i = 1:sz(1)
            for j = 1:sz(2)
                tempX = ranX(i,j)+i;
                tempY = ranY(i,j)+j;
                %If a pixel is chosen outside of the image, rechoose until
                %it is inside of the image
                while(tempX <= 0 || tempX > sz(1))
                    tempX = randi(n)-floor(n/2)+i;
                end
                while(tempY <= 0 || tempY > sz(2))
                    tempY = randi(m)-floor(m/2)+j;
                end
                %Replace the pixel
                out_img(i,j,k) = in_img(tempX,tempY,k);
            end
        end
    end
    
end


