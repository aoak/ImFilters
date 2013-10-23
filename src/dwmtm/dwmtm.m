% Adaptive DW MTM filter
% This filter employs a small window median filter 
% to determine the mean of the area and then takes
% arithmatic mean of the pixels falling in some range

% USAGE : out_im=dwmtm(im,n1,n2,c,show)
% where;
%        im = input image
%        n1 = smaller window size
%        n2 = larger window size
%        c = rejection parameter (lower means stricter)
%        show = (bool) set to 1 to display output image

function out_im=dwmtm(im,n1,n2,c,show)

% check if image is grayscale
if (length(size(im)) > 2 )
   error('The image should be gray-scale');
end

[rows, cols]=size(im);

medim=med(im,n1,0);
out_im=double(im);

marg2= (n2-1)/2;

for i= 1+marg2:rows-marg2
    for j=1+marg2:cols-marg2
        loc_med=medim(i,j);   % this is estimated local mean
        w1=im(i-marg2:i+marg2,j-marg2:j+marg2);
        w2=w1 > (loc_med-c);
        w3=w1 < (loc_med+c);
        w2= w2 & w3;
        w1 = double(w1) .* w2;
        out_im(i,j)= (sum(sum(w1)) / sum(sum(w2)) );
    end
end

out_im=uint8(out_im);
if (show == 1)
   imshow(out_im);
   title('Output adaptive DW-MTM filtered image');
end