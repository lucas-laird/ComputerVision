function NCCshift = NCCLR(leftImage,rightImage,window)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sz = size(leftImage);
NCCshift =zeros(sz(1),sz(2));
if(length(sz) == 3)
    leftImage = leftImage(:,:,1)*0.21+leftImage(:,:,2)*0.72+leftImage(:,:,3)*0.07;
    rightImage = rightImage(:,:,1)*0.21+rightImage(:,:,2)*0.72+rightImage(:,:,3)*0.07;
end
wind = floor(window/2);
nanPad = nan(sz(1)+2*wind,sz(2)+2*wind);
nanPad(wind+1:sz(1)+wind,wind+1:sz(2)+wind) = leftImage;
leftImage = nanPad;
nanPad = nan(sz(1)+2*wind,sz(2)+2*wind);
nanPad(wind+1:sz(1)+wind,wind+1:sz(2)+wind) = rightImage;
rightImage = nanPad;
for i = 1:sz(1)
    for j = 1:sz(2)
        ncc = [];
        x = i+wind;
        y = j+wind;
        leftWindow = leftImage(x-wind:x+wind,y-wind:y+wind);
        leftMean = mean(leftWindow(:));
        leftSquare = (sum(leftWindow(:)-leftMean)^2)^(1/2);
        leftVal = (leftWindow-leftMean)./leftSquare;
        for k = 1:63
            if(j+k <= sz(2))
                rightWindow = rightImage(x-wind:x+wind,y+k-wind:y+k+wind);
                rightMean = mean(rightWindow(:));
                rightSquare = (sum(rightWindow(:)-rightMean)^2)^(1/2);
                rightVal = (rightWindow-rightMean)./rightSquare;
                tempncc = leftVal.*rightVal;
                ncc = [ncc,sum(tempncc(:))];
                [minNCC,minInd] = min(ncc(:));
                if(length(minInd)> 1)
                    NCCshift(i,j) = minInd(1);
                else
                    NCCshift(i,j) = minInd;
                end
            end
        end
    end
end
end

