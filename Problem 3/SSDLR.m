function D = SSDLR(leftImage,rightImage,window,sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 3
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz = size(leftImage);
wind = floor(window/2); %How far left/right for the window
D = zeros(sz(1),sz(2));
tempssd = cell(sz(1),sz(2));
%%Gaussian Filter
filter = zeros(window,window);
for i = 1:window
    for j = 1:window
        x = i-wind-1;
        y = j-wind-1;
        filter(i,j) = (1/(2*pi*sigma^2))*exp(-((x^2+y^2)/(2*sigma^2)));
    end
end

%%Calculate ssd for each pixel
for i = wind+1:sz(1)-wind-1
    for j = wind+1:sz(2)-wind-1
        leftWindow = leftImage(i-wind:i+wind,j-wind:j+wind);
        leftWindow = double(leftWindow).*filter;
        for k = 1:64 %Check along the epipolar line
            if(j+k-1+wind <= sz(2))
                rightWindow = rightImage(i-wind:i+wind,j+k-1-wind:j+k-1+wind);
                rightWindow = double(rightWindow).*filter;
                diff = leftWindow-rightWindow;
                diff = diff.^2;
                tempssd{i,j}(k) = sum(diff(:));
            end
        end
    end
end

%%Uniqueness Constraint, If there is a tie, just choose the lower distance
%%one
takenPix = false(sz(1),sz(2));
%Randomize the order we look at pixels so as not to bias the disparity
randX = randperm(sz(1));
randY = randperm(sz(2));
for i = 1:sz(1)
    for j = 1:sz(2)
        candidates = tempssd{randX(i),randY(j)}(:);
        %Professor Fleming mentioned that this might be a source of error
        [minCand minInd] = sort(candidates);
        for k = 1:numel(minInd)
            %If it's taken, loop through possible matches until we find one
            %that isn't.
            if(takenPix(randX(i),randY(j)+minInd(k)) == false)
                D(randX(i),randY(j)) = minInd(k)-1;
                takenPix(randX(i),randY(j)+minInd(k)) = true;
                break;
            end
        end
    end
end
end

