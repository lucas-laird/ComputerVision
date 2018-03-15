function D = SSDRL(leftImage,rightImage,window,sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 3
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Exactly same function but goes right to left, ie checks negative direction
%in the leftWindow for a match.

sz = size(leftImage);
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
D = zeros(sz(1),sz(2));
tempssd = cell(sz(1),sz(2));
for i = 1:sz(1)
    for j = 1:sz(2)
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
                tempssd{i,j}(k) = sum(diff(:));
            end
        end
    end
end
takenPix = false(sz(1),sz(2));
randX = randperm(sz(1));
randY = randperm(sz(2));
for i = 1:sz(1)
    for j = 1:sz(2)
        candidates = tempssd{randX(i),randY(j)}(:);
        [minCand minInd] = sort(candidates);
        for k = 1:numel(minInd)
            if(takenPix(randX(i),randY(j)-minInd(k)) == false)
                D(i,j) = minInd(k);
                takenPix(randX(i),randY(j)+minInd(k)) = true;
                break;
            end
        end
    end
end
end

