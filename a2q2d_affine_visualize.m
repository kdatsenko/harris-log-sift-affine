% Visualise affine
function out = a2q2d_affine_visualize(ref, test, k)

if nargin<3
    k = 25;
end;

%read the images in for visualization component
ref_img = imread(ref);
[r, c, ~] = size(ref_img); 
[h, w, ~] = size(ref_img); 
test_img = imread(test);

% fill in the rows of the P matrix where every 2 rows represent 
% the x,y values of one of the four corners point of ref img
P = [1, 1, 0, 0, 1, 0; ...%top-left 
    0, 0, 1, 1, 0, 1; ...  
    1, r, 0, 0, 1, 0; ...%bottom-left
    0, 0, 1, r, 0, 1; ...
    
    c, 1, 0, 0, 1, 0; ... %top-right
    0, 0, c, 1, 0, 1; ...
    c, r, 0, 0, 1, 0; ... %bottom-right
    0, 0, c, r, 0, 1;];

affine_transf = a2q2c_affine_transf(ref, test, k);

points = P*affine_transf;

% Plot lines for dvd
imshow(test_img);
hold on;
line([points(1), points(3)],[points(2),points(4)],'Color','g', 'Linewidth', 2);
line([points(5), points(7)],[points(6),points(8)],'Color','g', 'Linewidth', 2);
line([points(1), points(5)],[points(2),points(6)],'Color','g', 'Linewidth', 2);
line([points(3), points(7)],[points(4),points(8)],'Color','g', 'Linewidth', 2);
hold off;
end