% Harris corner detection with 'nonmax' suppression function
function out = q1a(filename)
im = imread(filename);
img = rgb2gray(im); %get intensity values

[Gx,Gy] = imgradientxy(img);

Gx2 = Gx.*Gx;
Gy2 = Gy.*Gy;
GxGy = Gx.*Gy;

guass_filt = fspecial('gaussian');
Mx2 = conv2(Gx2, guass_filt, 'same');
My2 = conv2(Gy2, guass_filt, 'same');
Mxy = conv2(GxGy, guass_filt, 'same');

%alpha = 0.05; % 0.04 to 0.06

% Harris detector
% det of 2x2 matrix should be easy
determinant = Mx2.*My2 - Mxy.*Mxy;
trace = Mx2 + My2;
R_val = determinant ./ trace;
%R_val = determinant - (alpha*(trace.^2));

%threshold & non-maximal suppr of corner points
%Take only points of local maxima
max_R = max(max(R_val));
threshold = max_R*0.028;

% Perform non-maximal surpression
mx = nonmax(R_val, 3);
% Find the coordinates of the corner points
corner_p = (R_val == mx) & (mx > threshold);

%get coordinates of corner points
[pcols, prows] = find(corner_p);
imshow(img);
hold on;
plot(prows, pcols,'r*');

end