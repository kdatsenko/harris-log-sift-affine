% SIFT features for reference.png and test.png
function out = a2q2a(im1, im2)

% read images and grayscale
img1_col = imread(im1);
img1 = single(rgb2gray(img1_col)) ;
img2_col = imread(im2);
img2 = single(rgb2gray(img2_col)) ;

%compute the SIFT frames (keypoints) and descriptors
[f_im1,d_im1] = vl_sift(img1) ;
[f_im2,d_im2] = vl_sift(img2) ;

imshow(img1_col);
hold on;
% Plot images
perm = randperm(size(f_im1,2)) ;
sel = perm(1:100) ;
h1 = vl_plotframe(f_im1(:,sel)) ;
h2 = vl_plotframe(f_im1(:,sel)) ;
set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',2);
hold off;

imshow(img2_col);
hold on;
perm = randperm(size(f_im2,2)) ;
sel = perm(1:100) ;
h1 = vl_plotframe(f_im2(:,sel)) ;
h2 = vl_plotframe(f_im2(:,sel)) ;
set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',2);
hold off;

end