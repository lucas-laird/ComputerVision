leftImage = imread('frame_1L.png');
rightImage = imread('frame_1R.png');
leftImage = double(leftImage);
rightImage = double(rightImage);
sz = size(leftImage);
if(length(sz) == 3)
    leftImage = leftImage(:,:,1)*0.21+leftImage(:,:,2)*0.72+leftImage(:,:,3)*0.07;
    rightImage = rightImage(:,:,1)*0.21+rightImage(:,:,2)*0.72+rightImage(:,:,3)*0.07;
end
leftImage = double(leftImage)/256;
rightImage = double(rightImage)/256;
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
imshow(dcolor);
