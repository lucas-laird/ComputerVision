function NCCshift = NCCLR(leftImage,rightImage,window)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 3
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pad the image array with NaNs
sz = size(leftImage);
NCCshift = zeros(sz(1),sz(2));
wind = floor(window/2);
nanPad = nan(sz(1)+2*wind,sz(2)+2*wind);
nanPad(wind+1:sz(1)+wind,wind+1:sz(2)+wind) = leftImage;
leftImage = nanPad;
nanPad = nan(sz(1)+2*wind,sz(2)+2*wind);
nanPad(wind+1:sz(1)+wind,wind+1:sz(2)+wind) = rightImage;
rightImage = nanPad;
ncc = cell(sz(1),sz(2));
%Loop through and compute NCC for each window
for i = 1:sz(1)
    for j = 1:sz(2)
        x = i+wind;
        y = j+wind;
        leftWindow = leftImage(x-wind:x+wind,y-wind:y+wind);
        leftMean = mean(leftWindow(:));
        leftSquare = (sum(leftWindow(:)-leftMean)^2)^(1/2);
        leftVal = (leftWindow-leftMean)./leftSquare;
        for k = 1:40
            if(j+k <= sz(2))
                rightWindow = rightImage(x-wind:x+wind,y+k-wind:y+k+wind);
                rightMean = mean(rightWindow(:));
                rightSquare = (sum(rightWindow(:)-rightMean)^2)^(1/2);
                rightVal = (rightWindow-rightMean)./rightSquare;
                tempncc = leftVal.*rightVal;
                ncc{i,j}(k) = sum(tempncc(:));
            end
        end
    end
end
%If a pixel is taken, we can't use it.
takenPix = false(sz(1),sz(2));
randX = randperm(sz(1));
randY = randperm(sz(2));
%Uniqueness Constraint
for i = 1:sz(1)
    for j = 1:sz(2)
        candidates = ncc{randX(i),randY(j)}(:);
        [minCand, minInd] = sort(candidates);
        for k = 1:numel(minInd)
            if(takenPix(randX(i),randY(j)+minInd(k)) == false)
                %Loop through until we find one that isn't taken
                NCCshift(randX(i),randY(j)) = minInd(k)-1;
                takenPix(randX(i),randY(j)+minInd(k)) = true;
                break;
            end
        end
    end
end
end

