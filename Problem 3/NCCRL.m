function NCCshift = NCCRL(leftImage,rightImage,window)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 3
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Exactly the same as the left right version, just check in the negative
%direction in the left image for a match


sz = size(leftImage);
wind = floor(window/2);
nanPad = nan(sz(1)+2*wind,sz(2)+2*wind);
nanPad(wind+1:sz(1)+wind,wind+1:sz(2)+wind) = leftImage;
leftImage = nanPad;
nanPad = nan(sz(1)+2*wind,sz(2)+2*wind);
nanPad(wind+1:sz(1)+wind,wind+1:sz(2)+wind) = rightImage;
rightImage = nanPad;
ncc = cell(sz(1),sz(2));
for i = 1:sz(1)
    for j = 1:sz(2)
        x = i+wind;
        y = j+wind;
        rightWindow = rightImage(x-wind:x+wind,y-wind:y+wind);
        rightMean = mean(rightWindow(:));
        rightSquare = (sum(rightWindow(:)-rightMean)^2)^(1/2);
        rightVal = (rightWindow-rightMean)./rightSquare;
        for k = 1:63
            if(j-k > 0)
                leftWindow = leftImage(x-wind:x+wind,y-k-wind:y-k+wind);
                leftMean = mean(leftWindow(:));
                leftSquare = (sum(leftWindow(:)-leftMean)^2)^(1/2);
                leftVal = (leftWindow-leftMean)./leftSquare;
                tempncc = leftVal.*rightVal;
                ncc{i,j}(k) = sum(tempncc(:));
            end
        end
    end
end
takenPix = false(sz(1),sz(2));
randX = randperm(sz(1));
randY = randperm(sz(2));
%Uniqueness Constraint
for i = 1:sz(1)
    for j = 1:sz(2)
        candidates = ncc{randX(i),randY(j)}(:);
        [minCand, minInd] = sort(candidates);
        for k = 1:numel(minInd)
            if(takenPix(randX(i),randY(j)-minInd(k)) == false)
                NCCshift(i,j) = minInd(k);
                takenPix(randX(i),randY(j)+minInd(k)) = true;
                break;
            end
        end
    end
end
end

