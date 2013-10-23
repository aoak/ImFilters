% Wiener filter implementation is ready in MATLAB.
% Hence we will just call that function here

function out_im=wiener(im,n,show)

% check if image is grayscale
if (length(size(im)) > 2 )
   error('The image should be gray-scale');
end

im=double(im);

out_im=wiener2(im,[n n]);

out_im=uint8(out_im);
if (show == 1)
   imshow(out_im);
   title('Output median filtered image');
end