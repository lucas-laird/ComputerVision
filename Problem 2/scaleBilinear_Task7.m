function outImg = scaleBilinear_Task7(inImg, factor)
%factor should be a positive number
if(factor<=0)
    error('factor should be bigger than 0');
end

if(factor<=0)
    error('factor should be bigger than 0');
end
if(ischar(inImg))
 original = imread(inImg);
else
 original = inImg;
end %you can input name of image or the matrix after imread.
temp = mat2gray(original);%image normalization, convert uint8 to double. If not when you add the pixel value together, it will be constrained to 0~255 before you do average
[rowN,colN,channel] = size(temp); %read image size
scale_temp = zeros(round(factor*rowN),round(factor*colN),channel);

for k = 1:1:channel
    for i = 1:1:(rowN*factor)
        for j = 1:1:(colN*factor)
            row = floor(i/factor);
            col   = floor(j/factor);
            m = i/factor - row;
            n  = j/factor - col;
            %edge
            if(row<1)
               row = 1;
            end
            if(row>rowN-1)
                row = rowN-1;
            end
            if(col<1)
                col = 1;
            end
            if(col>colN-1)
               col = colN-1;   
            end 
            
            scale_temp(i,j,k) = (1-m)*(1-n)*temp(row,col,k) + (1-m)*n*temp(row,col+1,k) + m*(1-n)*temp(row+1,col,k)+m*n*temp(row+1,col+1,k);
        end
    end
end

outImg = uint8(round(255*scale_temp)); %denormalization
