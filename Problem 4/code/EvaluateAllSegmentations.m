% Quantitatively evaluate a segmentation method by comparing its computed
% segments against ground truth foreground-background segmentations.

% This loads cell arrays of string named gtNames and imageNames where
% ../imageNames{i} is the ith image and ../gtNames{i} is the ground truth
% segmentation for this image.
load('../cats.mat');

% Set the parameters for segmentation.
numClusters = 5;
clusteringMethod = 'kmeans';
featureFn = @ComputePositionColorFeatures;
normalizeFeatures = true;

% Since the images are different sizes, we specify a maximum number of
% pixels that we want to cluster and then use this to determine the resize
% for each image.
maxPixels = 3000;

% Whether or not to manually choose the foreground segments using
% ChooseSegments.
chooseSegmentsManually = false;

for i = 1:length(imageNames)
    img = imread(['../' imageNames{i}]);
    maskGt = imread(['../' gtNames{i}]);
    
    % Determine the number of pixels in this image.
    height = size(img, 1);
    width = size(img, 2)   ;
    numPixels = height * width;
    
    % Determine the amount of resize required for this image.
    resize = 0.2;
%     if numPixels > maxPixels
%         resize = sqrt(maxPixels / numPixels);
%     end   
    % Compute a segmentation for this imagetimverVal
    segments = ComputeSegmentation(img, numClusters, clusteringMethod, ...
                                   featureFn, normalizeFeatures, resize);
    
    % Evaluate the segmentation.
    if chooseSegmentsManually
        mask = ChooseSegments(segments);
        accuracy = EvaluateSegmentation(maskGt, mask);
    else
        accuracy = EvaluateSegmentation(maskGt, segments);
    end
    %fprintf('kmeans col no pos Accuracy for %s is %.4f\n', imageNames{i}, accuracy);
    meanAccuracy = meanAccuracy + accuracy;
end

meanAccuracy = meanAccuracy / length(imageNames);
fprintf('The kmeans col no pos mean accuracy for all images is %.4f\n', meanAccuracy);






