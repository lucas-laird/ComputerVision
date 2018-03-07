left_image = imread('frame_1L.png');
right_image = imread('frame_1R.png');
Diff = SSD(left_image,right_image,5,63,1);