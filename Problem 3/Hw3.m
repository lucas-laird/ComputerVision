%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 3
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Load Images
left_image = imread('frame_1L.png');
right_image = imread('frame_1R.png');
left_image = rgb2gray(left_image);
right_image = rgb2gray(right_image);
sz = size(left_image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%SSD Plotting
'starting ssd'
SSD3 = SSDLR(left_image,right_image,3,1);
SSD5 = SSDLR(left_image,right_image,5,1);
SSD7 = SSDLR(left_image,right_image,7,1);
figure;
hold on;
subplot(2,2,1)
imshow(disparity(left_image,right_image),[0,64]);
title('Matlab');
colormap(gca,jet);
subplot(2,2,2)
imshow(SSD3,[0,63])
colormap(gca,jet);
title('SSD 3x3');
subplot(2,2,3)
imshow(SSD5,[0,63])
colormap(gca,jet);
title('SSD 5x5');
subplot(2,2,4)
imshow(SSD7,[0,63])
colormap(gca,jet);
title('SSD 7x7');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%NCC plotting
'starting NCC'
NCC3 = NCCLR(left_image,right_image,3);
NCC5 = NCCLR(left_image,right_image,5);
NCC7 = NCCLR(left_image,right_image,7);
figure;
hold on;
subplot(2,2,1)
imshow(disparity(left_image,right_image),[0,64]);
title('Matlab');
colormap(gca,jet);
subplot(2,2,2)
imshow(NCC3,[0,63])
colormap(gca,jet);
title('NCC 3x3');
subplot(2,2,3)
imshow(NCC5,[0,63])
colormap(gca,jet);
title('NCC 5x5');
subplot(2,2,4)
imshow(NCC7,[0,63])
colormap(gca,jet);
title('NCC 7x7');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Outliers Map
'Outliers'
SSD3R = SSDRL(left_image,right_image,3,1);
NCC3R = NCCRL(left_image,right_image,3);
SSDtlr = Outliers(SSD3,SSD3R,1);
NCCtlr = Outliers(NCC3,NCC3R,1);
figure;
hold on;
subplot(1,2,1)
imshow(SSDtlr)
title('SSD outliers');
subplot(1,2,2)
imshow(NCCtlr)
title('NCC outliers');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Depth from Disparity

%Since I don't have the stereoparams, this is what the call looks like

points3D = calcDistance(SSD3,stereoParams);
z = points3D(:,:,3);
figure;
hold on;
subplot(1,2,1)
imshow(z, [min(z(:)),max(z(:))])
title('SSD depth')
subplot(1,2,2)
points3D = calcDistance(NCC3,stereoParams);
z = points3D(:,:,3);
imshow(z, [min(z(:)),max(z(:))])
title('NCC depth')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Errors
'Errors'
ground_truth = imread('frame_1LR.png');
SSDerrorLR = abs(SSD3-double(ground_truth));
NCCerrorLR = abs(NCC3-double(ground_truth));
figure;
hold on;
subplot(2,2,1)
imshow(ground_truth);
subplot(2,2,2)
imshow(SSDerrorLR,[0,max(SSDerrorLR(:))]);
title('SSD Error');
subplot(2,2,3)
imshow(NCCerrorLR, [0,max(NCCerrorLR(:))]);
title('NCC error');
subplot(2,2,4)
histogram(SSDerrorLR(:))
title('Histogram of SSD error');
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Dynamic Programming
'DP'
leftImage = double(left_image)/256;
rightImage = double(right_image)/256;
maxDisp = 63;
d = zeros(sz(1),sz(2));
for i = 1:sz(1)
    e1 = leftImage(i,:);
    e2 = rightImage(i,:);
    d(i,:) = stereoDP(e1,e2,maxDisp,0.01);
end
d = (d-min(d(:)))/(max(d(:))-min(d(:)));
dcolor = zeros(sz(1),sz(2),3);
dcolor(:,:,1) = d;
dcolor(:,:,2) = d;
dcolor(:,:,3) = d;
[NaNR NaNC] = find(isnan(d));
for i = 1:numel(NaNR)
    dcolor(NaNR(i),NaNC(i),1) = 1;
    dcolor(NaNR(i),NaNC(i),2) = 0;
    dcolor(NaNR(i),NaNC(i),3) = 0;
end
imshow(dcolor)
title('Dynamic Programming disparity');




