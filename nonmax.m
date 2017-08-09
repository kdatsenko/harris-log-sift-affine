function nonmax = nonmax(im, radius)
%radius - radius of region considered in non-maximal
%         suppression.

%ordfilt2(A,order,domain) replaces each element in A by the orderth 
%element in the sorted set of neighbors specified by the nonzero 
%elements in domain. 

% perform non-maximal suppression using ordfilt2
domain=fspecial('disk',radius)>0; %dilation mask, circular element
num_pixels_domain = sum(sum(domain));
nonmax = ordfilt2(im, num_pixels_domain, domain); % Grey-scale dilate.