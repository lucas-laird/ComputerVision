function dist = calcDistance(d,stereoparams)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 3
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = stereoparams.CameraParameters1.FocalLength;
f = mean(f); %Get the focal length of the camera
c1 = stereoparams.CameraParameters1.PrincipalPoint;
c2 = stereoparams.CameraParameters2.PrincipalPoint;
B = ((c2(1)-c1(1))^2 + (c2(2)-c1(2))^2)^(1/2); %Calculate baseline
sz = size(d);
dist = zeros(sz(1),sz(2),3);
[X,Y] = meshgrid(sz(1),sz(2));
dist(:,:,1) = X; %X coordinates
dist(:,:,2) = Y; %Y coordinates
for i = 1:sz(1)
    for j = 1:sz(2)
        if(d(i,j) == 0)
            dist(i,j,3)= inf; %Avoid divide by zero
        else
            dist(i,j,3) = f*B/d(i,j); %Calculate the z depth.
        end
    end
end
end

