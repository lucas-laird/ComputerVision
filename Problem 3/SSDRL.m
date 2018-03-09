function D = SSDRL(leftImage,rightImage,window,sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sz = size(leftImage);
if(length(sz) == 3)
    leftImage = leftImage(:,:,1)*0.21+leftImage(:,:,2)*0.72+leftImage(:,:,3)*0.07;
    rightImage = rightImage(:,:,1)*0.21+rightImage(:,:,2)*0.72+rightImage(:,:,3)*0.07;
end
wind = floor(window/2);
ind = -floor(window/2):floor(window/2);
[X,Y] = meshgrid(ind,ind);
filter = exp(-(X.^2+Y.^2)/(2*sigma*sigma));
nanPad = nan(sz(1)+2*wind,sz(2)+2*wind);
nanPad(wind+1:sz(1)+wind,wind+1:sz(2)+wind) = leftImage;
leftImage = nanPad;
nanPad = nan(sz(1)+2*wind,sz(2)+2*wind);
nanPad(wind+1:sz(1)+wind,wind+1:sz(2)+wind) = rightImage;
rightImage = nanPad;
minSSDShift = [];
for i = 1:sz(1)
    for j = 1:sz(2)
        ssd = 1000000;
        x = i+wind;
        y = j+wind;
        rightWindow = rightImage(x-wind:x+wind,y-wind:y+wind);
        rightWindow(:,:) = rightWindow(:,:).*filter;
        for k = 1:63
            if(j-k > 0)
                leftWindow = leftImage(x-wind:x+wind,y-k-wind:y-k+wind);
                leftWindow(:,:) = leftWindow(:,:).*filter;
                diff = leftWindow-rightWindow;
                diff = diff.^2;
                tempssd = sum(diff(:));
                if(tempssd <= ssd)
                    ssd = tempssd;
                    minSSDShift(i,j) = k;
                end
            end
        end
    end
end
D = minSSDShift;
end

