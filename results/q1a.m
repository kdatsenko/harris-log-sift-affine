% Harris corner detection
function out = q1a(filename)
im = imread(filename);
img = rgb2gray(im); %get intensity values

sigma = 3;
imgS = conv2(img,fspecial('Gaussian',[25 25],sigma),'same');

[Gx,Gy] = imgradientxy(imgS);

Gx2 = Gx.*Gx;
Gy2 = Gy.*Gy;
GxGy = Gx.*Gy;

%Guassian is rotationally symmetric, three conv in total
sigma_w = 16;
guass_filt = fspecial('gaussian', [25, 25], sigma_w);
Mx2 = conv2(Gx2, guass_filt, 'same');
My2 = conv2(Gy2, guass_filt, 'same');
Mxy = conv2(GxGy, guass_filt, 'same');

%alpha = 0.05; % 0.04 to 0.06

% Harmonic mean detector
determinant = Mx2.*My2 - Mxy.*Mxy;
trace = Mx2 + My2;
R_val = determinant ./ trace;
%R_val = determinant - alpha*(trace.^2);

%threshold 
max_R = max(max(R_val));
threshold = max_R*0.028;

[r, c] = size(img);
local_max = zeros(r, c);

%non maximal supression within neighbourhood of 3x3
%We check if R points are above threshold
thresh_suppress = (R_val > threshold);    
[sx, sy] = size(R_val);
% Keep if pixel is greater than surrounding pixels
local_maxima_nonpad = (R_val(2:sx-1,2:sy-1) > R_val(1:sx-2,1:sy-2)) & ...
    (R_val(2:sx-1,2:sy-1) > R_val(1:sx-2,2:sy-1)) & ...
    (R_val(2:sx-1,2:sy-1) > R_val(1:sx-2,3:sy)) & ...
    (R_val(2:sx-1,2:sy-1) > R_val(2:sx-1,1:sy-2)) & ...
    (R_val(2:sx-1,2:sy-1) > R_val(2:sx-1,3:sy)) & ...
    (R_val(2:sx-1,2:sy-1) > R_val(3:sx,1:sy-2)) & ...
    (R_val(2:sx-1,2:sy-1) > R_val(3:sx,2:sy-1)) & ...
    (R_val(2:sx-1,2:sy-1) > R_val(3:sx,3:sy));

local_max(2:sx-1, 2:sy-1) = local_maxima_nonpad;
local_max = local_max & thresh_suppress;
 
%get coordinates of corner points
[pcols, prows] = find(local_max == 1);
imshow(img);
hold on;
plot(prows, pcols,'r.');

end