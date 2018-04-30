% Simple script to run ComputeSegmentation.

% Read the input image.

%'cat_march.jpg',@ComputePositionColorFeatures,
imageNames = {'stripey-kitty.jpg','black_kitten_star.jpg'};
featureFn = {@ComputeColorFeatures,@ComputePositionColorFeatures};
clusteringMethod = 'hac';
maxPixels = 3000;
for i = 1:length(imageNames)
    img = imread(['../imgs/'  imageNames{i}]);
% Choose the number of clusters and the clustering method.
    k = 3;

    % Choose the feature function that will be used. The @ syntax creates a
    % function handle; this allows us to pass a function as an argument to
    % another function.
    featureFnN = featureFn{i};

    % Whether or not to normalize features before clustering.
    normalizeFeatures = true;

    % Whether or not to resize the image before clustering. If this script
    % runs too slowly then you should set resize to a value less than 1.
    numPixels = size(img,1)*size(img,2);
    resize = 1;
    if numPixels > maxPixels
        resize = sqrt(maxPixels/numPixels);
    end

    % Use all of the above parameters to actually compute a segmentation.
    segments = ComputeSegmentation(img, k, clusteringMethod, featureFnN, ...
                                   normalizeFeatures, resize);

    % Show the computed segments in two different ways.
    ShowSegments(img, segments);
    ShowMeanColorImage(img, segments);

end