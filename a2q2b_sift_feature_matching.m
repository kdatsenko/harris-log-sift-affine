% top k correspondences
function [f_im1, f_im2, k_matches_im1, k_matches_im2, ksize] = a2q2b_sift_feature_matching(ref, test, k, visualize)

% read images and grayscale
img1_col = imread(ref);
img1 = single(rgb2gray(img1_col)) ;
img2_col = imread(test);
img2 = single(rgb2gray(img2_col)) ;

%compute the SIFT frames (keypoints) and descriptors
[f_im1,d_im1] = vl_sift(img1) ;
[f_im2,d_im2] = vl_sift(img2) ;

[k_matches_im1, k_matches_im2, ksize] = match_k(d_im1, d_im2, k);
%ksize - limit on matches that could be made

if (visualize)
   colours = zeros(ksize, 3);
   for c = 1:ksize
    colours(c, :) = rand(1, 3);
   end
    % Plot images
    figure;
    imshow(img1_col);
    for i=1:ksize
        h1 = vl_plotframe(f_im1(:, k_matches_im1(i) ));
        set(h1,'color',colours(i, :),'linewidth',3) ;
    end
    figure;
    imshow(img2_col);
    for i=1:ksize
        h1 = vl_plotframe(f_im2(:, k_matches_im2(i) ));
        set(h1,'color',colours(i, :),'linewidth',3) ;
    end 
end

end