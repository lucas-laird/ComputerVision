
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 2
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pic1 = imread('uttower1.jpg'); %Destination Image
pic2 = imread('uttower2.jpg'); %Source Image
points = GetPoints(pic1,pic2,10);
homographies = cell(20,1);
distances = zeros(20,1);
for i = 1:20
    h = computeHomography(points,10);
    homographies{i} = h; %calculate the homographies
    dist = calcDistance(points,h); %check avg distance
    distances(i) = dist;
end
[M,I] = min(distances); %choose minimum one
h = homographies{I};
subplot(1,3,1)
imshow(mosaic(pic1,pic2,points,h)); %call mosaic
subplot(1,3,2)
imshow(pic1)
subplot(1,3,3)
imshow(pic2)
hold off

%same idea as above but with two new pictures
BCleft = imread('BCleft2.jpg');
BCright = imread('BCright2.jpg');
pointsBC = GetPoints(BCright,BCleft,10);
homographies = cell(20,1);
distances = zeros(20,1);
for i = 1:20
    h = computeHomography(points,10);
    homographies{i} = h;
    dist = calcDistance(points,h);
    distances(i) = dist;
end
[M,I] = min(distances);
h = homographies{I};
subplot(1,3,1)
imshow(mosaic(BCright,BCleft,pointsBC,h));
subplot(1,3,2)
imshow(BCright)
subplot(1,3,3)
imshow(BCleft)
hold off


destination = imread('billboard.jpeg');%This is the image we are going to put something on
insertImage = imread('insert_bill.jpg'); %this is what we are gonna insert
insertPoints = GetPoints(insertImage,destination,4); %Choose the corners
h = computeHomography(insertPoints,4);%calculate the homography
subplot(1,3,1)
imshow(insertImg(destination,insertImage,h)); %add it in
subplot(1,3,2)
imshow(insertImage)
subplot(1,3,3)
imshow(destination)