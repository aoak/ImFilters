% This is a spacial median filter
% Usage:
% out_image = med(in_image,N,show)
% inputs :
% in_image : input gray scale image
% N = mask size (should be odd int)
% show = should be a bool. set 1 to display the output image
%                              0 otherwise

function out_im=med(im,n,show)

% check if image is grayscale
if (length(size(im)) > 2 )
   error('The image should be gray-scale');
end

[rows, cols]=size(im);
out_im=double(im);
b_len=n^2;    % number of elements in the block

% we dont do filtering on margins
marg=(n-1)/2;

for i=1+marg:rows-marg
   for j=1+marg:cols-marg
      block=im(i-marg:i+marg,j-marg:j+marg);
      out_im(i,j)=median(double(reshape(block,1,b_len)));
   end
end

out_im=uint8(out_im);
if (show == 1)
   imshow(out_im);
   title('Output median filtered image');
end
