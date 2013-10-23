% This function is to estimate the standard deviation of the gaussian noise
% in the image using Immerkaer’s fast method

% USAGE : sigma=imm(im)

function sigma=imm(im)

% check if image is grayscale
if (length(size(im)) > 2 )
   error('The image should be gray-scale');
end

im=double(im);
[rows, cols]=size(im);

mask = [1, -2, 1;
        -2, 4, -2;
        1, -2, 1];
    
outim=conv2(im,mask);
avg=sum(sum(abs(outim)));
avg=avg/(6*(cols-2)*(rows-2));
sigma=avg* sqrt(pi/2);