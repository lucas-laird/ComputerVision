pic1 = imread('uttower1.jpg');
pic2 = imread('uttower2.jpg');
points = GetPoints(pic1,pic2);
homographies = cell(20,1);
distances = zeros(20,1);
for i = 1:20
    h = computeHomography(points);
    homographies{i} = h;
    point = zeros(1,3);
    point(1) = points(1,1,1);
    point(2) = points(2,1,1);
    point(3) = 1;
    dist = calcDistance(point,h);
    distances(i) = dist;
end
[M,I] = min(distances);
h = homographies{I};
