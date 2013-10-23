% This is a spacial low pass filter (smoothening)
% Usage:
% out_image = smooth(in_image,N,show)
% inputs :
% in_image : input gray scale image
% N = mask size (should be odd int)
% show = should be a bool. set 1 to display the output image
%                              0 otherwise

function out_im=smooth(im,n,show)

% check if image is grayscale
if (length(size(im)) > 2 )
   error('The image should be gray-scale');
end

mask=ones(n);
[rows, cols]=size(im);
out_im=double(im);
norm=sum(sum(mask));

% we dont do filtering on margins
marg=(n-1)/2;

for i=1+marg:rows-marg
   for j=1+marg:cols-marg
      block=im(i-marg:i+marg,j-marg:j+marg);
      out_im(i,j)=sum(sum(block.*mask))/norm;
   end
end

out_im=uint8(out_im);
if (show == 1)
   imshow(out_im);
   title('Output smoothened image');
end
