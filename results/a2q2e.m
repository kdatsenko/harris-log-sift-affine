%Hint: examine the settings of your feature calculation to improve your correspondence. 
%a2q2e('colourTemplate.png', 'colourSearch.png', 22, 1);
function [f_im1, f_im2, k_matches_im1, k_matches_im2, ksize] = a2q2e(ref, test, k, visualize)

img1_col_rgb = imread(ref);
img1 = single(rgb2gray(img1_col_rgb));
img2_col_rgb = imread(test);
img2 = single(rgb2gray(img2_col_rgb));

img1_col = rgb2hsv(img1_col_rgb);
img2_col = rgb2hsv(img2_col_rgb);

%compute the SIFT frames (keypoints) and descriptors
[f_im1,~] = vl_sift(img1) ;
[f_im2,~] = vl_sift(img2) ;

for i = 1:3
    [f1{i}, d1{i}] = vl_sift(single(img1_col(:,:,i)), 'frames', f_im1);
    [f2{i}, d2{i}] = vl_sift(single(img2_col(:,:,i)), 'frames', f_im2);
end

f_im1 = f1{1}; %f1{1}, f1{2}, f1{3} are identical features in same order
d_im1 = cat(1, d1{:}); %feature vector that is 3*128 in length
f_im2 = f2{1};
d_im2 = cat(1, d2{:});

[k_matches_im1, k_matches_im2, ksize] = match_k(d_im1, d_im2, k);
%ksize - limit on matches that could be made

if (visualize)
    colours = zeros(ksize, 3);
    for c = 1:ksize
        colours(c, :) = rand(1, 3);
    end
    % Plot images
    figure;
    imshow(img1_col_rgb);
    for i=1:ksize
        h1 = vl_plotframe(f_im1(:, k_matches_im1(i) ));
        set(h1,'color',colours(i, :),'linewidth',4) ;
    end
    figure;
    imshow(img2_col_rgb);
    for i=1:ksize
        h1 = vl_plotframe(f_im2(:, k_matches_im2(i) ));
        set(h1,'color',colours(i, :),'linewidth',4) ;
    end
end


end