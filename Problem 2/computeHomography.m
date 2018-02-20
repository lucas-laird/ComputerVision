function [h] = computeHomography(points,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 2
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
randPoints = randperm(n,4);
p11 = points(:,randPoints(1),1);
p12 = points(:,randPoints(2),1);
p13 = points(:,randPoints(3),1);
p14 = points(:,randPoints(4),1);

p21 = points(:,randPoints(1),2);
p22 = points(:,randPoints(2),2);
p23 = points(:,randPoints(3),2);
p24 = points(:,randPoints(4),2);

%Point matrix for solving
A1 = [-p11(1),-p11(2),-1,0,0,0,p11(1)*p21(1), p11(2)*p21(1),p21(1);...
      0,0,0, -p11(1), -p11(2), -1, p11(1)*p21(2), p11(2)*p21(2), p21(2)];
A2 = [-p12(1),-p12(2),-1,0,0,0,p12(1)*p22(1), p12(2)*p22(1),p22(1);...
      0,0,0, -p12(1), -p12(2), -1, p12(1)*p22(2), p12(2)*p22(2), p22(2)];
A3 = [-p13(1),-p13(2),-1,0,0,0,p13(1)*p23(1), p13(2)*p23(1),p23(1);...
      0,0,0, -p13(1), -p13(2), -1, p13(1)*p23(2), p13(2)*p23(2), p23(2)];
A4 = [-p14(1),-p14(2),-1,0,0,0,p14(1)*p24(1), p14(2)*p24(1),p24(1);...
      0,0,0, -p14(1), -p14(2), -1, p14(1)*p24(2), p14(2)*p24(2), p24(2)];
A = cat(1,A1,A2,A3,A4);
%SVD to get the last vector in V
[U, S, V] = svd(A);
h = V(:,end);
h = reshape(h,[3,3]); 
%Transpose since reshape is weird
h = h';
 
end

