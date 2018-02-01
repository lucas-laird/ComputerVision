% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 1
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter','Gaussian Filter', 'Frost Image', ...
    'Scale Nearest','Scale Bilinear', 'Swirl','Famous Me');  % as you develop functions, add buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
           menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter','Gaussian Filter');  % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda');
           switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename = 'mandrill1.jpg';
               case 3
                   filename = 'sully.bmp';
               case 4
                   filename = 'yoda.bmp';
               % fill in cases for all the images you plan to use
           end
           current_img = imread(filename);
       case 3
           % Display image
           figure
           imagesc(current_img);
           if size(current_img,3) == 1
               colormap gray
           end
           
       case 4
           % Mean Filter
           
           % 1. Ask the user for size of kernel
           k_size = input('What kernel size would you like?  ');
           % 2. Call the appropriate function
           newImage = meanFilter(current_img, k_size); % create your own function for the mean filter
           
           % 3. Display the old and the new image using subplot
           subplot(2,1,1);
           imagesc(current_img)
           if size(current_img,3) == 1
               colormap gray
           end
           subplot(2,1,2)
           imagesc(newImage)
           if size(newImage,3) == 1
               colormap gray
           end
           
           % subplot(...)
           %imagesc(newImage)
           
           
           % 4. Save the newImage to a file
           switch image_choice
               case 1
                   nfilename = sprintf('lena1-mean%i.jpg',k_size);
               case 2
                   nfilename = sprintf('mandrill1-mean%i.jpg',k_size);
               case 3
                   nfilename = sprintf('sully-mean%i.bmp',k_size);
               case 4
                   nfilename = sprintf('yoda-mean%i.bmp',k_size);
           end
           imwrite(newImage,nfilename);
       case 5
           %Gaussian Filter
           sigma = input('What sigma would you like?  ');
           newImage = gaussFilter(current_img,sigma);
           subplot(2,1,1)
           imagesc(current_img);
           subplot(2,1,2)
           imagesc(newImage);
           
           switch image_choice
               case 1
                   nfilename = sprintf('lena1-gauss%.0f.jpg',sigma);
               case 2
                   nfilename = sprintf('mandrill1-gauss%.0f.jpg',sigma);
               case 3
                   nfilename = sprintf('sully-gauss%.0f.bmp',sigma);
               case 4
                   nfilename = sprintf('yoda-gauss%.0f.bmp',sigma);
           end
           imwrite(newImage,nfilename);
       case 6
           %Frosty Filter
           n = input('Choose a positive n  ');
           m = input('Choose a positive m ');
           newImage = frosty(current_img,n,m);
           subplot(2,1,1)
           imagesc(current_img);
           subplot(2,1,2)
           imagesc(newImage);
           
           switch image_choice
               case 1
                   nfilename = sprintf('lena1-frosty%i-%i.jpg',n,m);
               case 2
                   nfilename = sprintf('mandrill1-frosty%i-%i.jpg',n,m);
               case 3
                   nfilename = sprintf('sully-frosty%i-%i.bmp',n,m);
               case 4
                   nfilename = sprintf('yoda-frosty%i-%i.bmp',n,m);
           end
           imwrite(newImage,nfilename);
       case 7
           %Scale Nearest
           %Scale using nearest neighbor interpolation
           factor = input('Choose a positive factor  '); 
           newImage = scaleNearest(current_img,factor);
           subplot(1,2,1)
           imagesc(current_img);
           subplot(1,2,2)
           imagesc(newImage);
           
           switch image_choice
               case 1
                   nfilename = sprintf('lena1-scalenear%.0f.jpg',factor);
               case 2
                   nfilename = sprintf('mandrill1-scalenear%.0f.jpg',factor);
               case 3
                   nfilename = sprintf('sully-scalenear%.0f.bmp',factor);
               case 4
                   nfilename = sprintf('yoda-scalenear%.0f.bmp',factor);
           end
           imwrite(newImage,nfilename);
       case 8
           %scale bilinear
           %Ask for factor and scale bilinear interpolation
           factor = input('Choose a positive factor  '); 
           newImage = scaleBilinear(current_img,factor);
           %Plot and save
           subplot(1,2,1)
           imagesc(current_img);
           subplot(1,2,2)
           imagesc(newImage);
           
           switch image_choice
               case 1
                   nfilename = sprintf('lena1-scaleBL%.0f.jpg',factor);
               case 2
                   nfilename = sprintf('mandrill1-scaleBL%.0f.jpg',factor);
               case 3
                   nfilename = sprintf('sully-scaleBL%.0f.bmp',factor);
               case 4
                   nfilename = sprintf('yoda-scaleBL%.0f.bmp',factor);
           end
           imwrite(newImage,nfilename);
       case 9
           %Swirl
           %%Ask for factor and call swirl
           factor = input('Choose a factor by which to swirl  ');
           ox = input('Choose the row which you would like to center on  ');
           oy = input('Choose the column which you would like to center on  ');
           newImage = swirl(current_img,ox,oy,factor);
           %Plot and save image
           subplot(1,2,1)
           imagesc(current_img);
           subplot(1,2,2)
           imagesc(newImage);
           
           switch image_choice
               case 1
                   nfilename = sprintf('lena1-swirl%i-%i-%.0f.jpg',...
                       ox,oy,factor);
               case 2
                   nfilename = sprintf('mandrill1-swirl%i-%i-%.0f.jpg',...
                       ox,oy,factor);
               case 3
                   nfilename = sprintf('sully-swirl%i-%i-%.0f.bmp',...
                       ox,oy,factor);
               case 4
                   nfilename = sprintf('sully-swirl%i-%i-%.0f.bmp',...
                       ox,oy,factor);
           end
           imwrite(newImage,nfilename);
       case 10 
           %Famous Me
           
           %%Inserting wrench into picture, calculating possible range for
           %%it to be inserted.
           ins_img = imread('wrench.jpg');
           sins = size(ins_img);
           sin = size(current_img);
           rangeX = sin(1)-sins(1);
           rangeY = sin(2)-sins(2);
           text1 = sprintf('Pick a row from 1 to %i  ',rangeX);
           text2 = sprintf('Pick a column from 1 to %i  ',rangeY);
           x = input(text1);
           y = input(text2);
           
           %Call Famous Me
           newImage = famousMe(current_img,ins_img,x,y);
           %Plot
           subplot(1,3,1)
           imagesc(current_img);
           subplot(1,3,2)
           imagesc(newImage);
           subplot(1,3,3)
           imagesc(ins_img);
           
           switch image_choice
               case 1
                   nfilename = sprintf('lena1-famMe%i-%i.jpg',...
                       x,y);
               case 2
                   nfilename = sprintf('mandrill1-famMe%i-%i.jpg',...
                       x,y);
               case 3
                   nfilename = sprintf('sully-famMe%i-%i.bmp',...
                       x,y);
               case 4
                   nfilename = sprintf('sully-famMe%i-%i.bmp',...
                       x,y);
           end
           imwrite(newImage,nfilename);
           
   end
   % Display menu again and get user's choice
   choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter','Gaussian Filter','Frost Filter', ...
    'Scale Nearest', 'Scale Bilinear', 'Swirl','Famous Me');  
% as you develop functions, add buttons for them here
end
