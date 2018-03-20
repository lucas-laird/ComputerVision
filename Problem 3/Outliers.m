function Tlr = Outliers(LR,RL,threshold)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lucas Laird 
% CSCI 4830 Computer Vision
% Homework 3
% Ioana Fleming
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz = size(LR);
Tlr = zeros(sz(1),sz(2));
for i = 1:sz(1)
    for j = 1:sz(2)
        if(j-LR(i,j) < 1) %If the offset is out of the image range, set it to 1
            Tlr(i,j) = 1;
        else
            Tlr(i,j) = abs(LR(i,j)-RL(i,j-LR(i,j)));
            if(Tlr(i,j) > threshold)
                Tlr(i,j) = 1; %if > than threshold set to 1
            else
                Tlr(i,j) = 0;  %otherwise set to 0
            end
        end
    end
end
end

