% This is an alpha trimmed filter
% Usage:
% out_image = alpha(in_image,N,a,show)
% inputs :
% in_image : input gray scale image
% N = mask size (should be odd int)
% a = parameter alpha, should be integer less than N^2/2
% show = should be a bool. set 1 to display the output image
%                              0 otherwise

function out_im=alpha(im,n,a,show)

% check if image is grayscale
if (length(size(im)) > 2 )
   error('The image should be gray-scale');
end

if (a > floor(n^2/2))
   error('Alpha is too big for the mask size');
end

[rows, cols]=size(im);
out_im=double(im);
b_len=n^2;    % number of elements in the block

% we dont do filtering on margins
marg=(n-1)/2;

for i=1+marg:rows-marg
   for j=1+marg:cols-marg
      block=im(i-marg:i+marg,j-marg:j+marg);
      sorted=sort(reshape(block,1,b_len));
      selected=sorted(a+1:b_len-a);
      out_im(i,j)=mean(selected);
   end
end

out_im=uint8(out_im);
if (show == 1)
   imshow(out_im);
   title('Output alpha trimmed filtered image');
end
