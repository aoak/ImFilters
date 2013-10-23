% Adaptive MMSE filter
% this filter checks the local standard deviation wrt noise standard dev
% if local std is more, then mean filter is not employed.
% USAGE: 
%       out_im = adpt_mmse(in_im,N,show)


function out_im=adpt_mmse(im,n,show)

% check if image is grayscale
if (length(size(im)) > 2 )
   error('The image should be gray-scale');
end

im=double(im);
block=ones(1,n*n);
[rows, cols]=size(im);
out_im=double(im);
marg=(n-1)/2;
l1=n*n;

% first, lets calculate the noise standard deviation

sigma_n=imm(im);

% now iterate the image

for i=1+marg:rows-marg
    for j=1+marg:cols-marg
        % cut out the local block
        block=reshape(im(i-marg:i+marg,j-marg:j+marg),1,l1);
        % now find the std dev of this block
        var_l=var(block);
        sigma_l=sqrt(var_l);
        if sigma_l < sigma_n
            % apply mean filter
            out_im(i,j)=mean(block);
            % else keep original value
        end
    end
end


out_im=uint8(out_im);
if (show == 1)
   imshow(out_im);
   title('Output MMSE filtered image');
end