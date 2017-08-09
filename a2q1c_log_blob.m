function out = a2q1c_log_blob(filename)

source = rgb2gray(imread(filename));
img = double(source);
% Initial parameter settings
num_scales = 25;
antialias_sigma = 0.5;
contrast_threshold = 0.03;
curvature_const = 12;

%% Filter over a set of scales
LoG = zeros(size(img,1),size(img,2),num_scales+2);

k = 2^(2/num_scales); %1.1, 2.0
initSigma = 1.1;
%source_antialiased = conv2(img, fspecial('gaussian',[25 25], 0.5), 'same');
imgS = img;% = source_antialiased;

for sc = 1:num_scales+2
    sigma =  k.^(sc-1)*initSigma;
    hs= max(25,min(floor(sigma*6),128));
    HL =  fspecial('log', [hs hs], sigma); %normalized kernel
    imFiltered = conv2(imgS,HL,'same'); % filter the image with LoG
    % save square of the response for current level
    LoG(:, :, sc) = (sigma^2)* imFiltered;
end   
    
disp('    Created LoG Scale Space');
   
%% Get Keypoints: LoG extrema
% top and bottom scales are only used to check for extrema within middle
% space. LoGs of scale 2, 3, 4 correspond to LoG_Keypoints of scales 1, 2
LoG_Keypoints = zeros(size(img,1),size(img,2),num_scales);
for sc = 2:num_scales
	LoG_Keypoints(:,:,sc-1) = extrema(LoG(:,:,sc+1), LoG(:,:,sc), LoG(:,:,sc-1)); 
end

disp('    Got KeyPoints: LoG extrema');

%% Filter Keypoints: Remove low contrast and edge keypoints
for sc = 1:num_scales    
    [points_x, points_y] = find(LoG_Keypoints(:,:,sc));  % indices of the Keypoints
    
    %find(DoG_Keypts{oct,sc})
    num_keypoints = length(points_x); % number of Keypoints
    scale = LoG(:, :, sc+1); %test all keypoints on this scale
    
    for k = 1:num_keypoints %for each keypoint
        x = points_x(k);
        y = points_y(k);
        %% Filter points with low contrast
        if (abs(scale(x,y)) < contrast_threshold)
            LoG_Keypoints(x,y,sc) = 0;
        else % Filter keypoints located on edges
            % Compute a 2x2 Hessian Matrix at (x,y) from LoG
            Dxy = scale(x-1,y-1) + scale(x+1,y+1) - scale(x-1,y+1) - scale(x+1,y-1);
            Dxx = scale(x-1,y) + scale(x+1,y) - 2*scale(x,y);    
            Dyy = scale(x,y+1) + scale(x,y-1) - 2*scale(x,y);
            
            %% Detect edge points 
            trace = Dxx + Dyy;
            determinant = Dxx*Dyy - Dxy*Dxy;
            curvature = (trace^2)/determinant;
            curv_thresh = ((curvature_const+1)^2)/curvature_const;
            if (curvature > curv_thresh || determinant < 0)
                LoG_Keypoints(x,y,sc)= 0;
            end
        end
    end
end

disp('    Filtered out keypoints with low contrast or on edges');

%% Visualize Result
imshow(source);
hold on;
for i=1:num_scales
    scale = LoG_Keypoints(:,:,i);
    [pcols, prows] = find(scale);
    plot(prows, pcols,'r.');
    for j=1:length(pcols)
        rad = i*2^(1/num_scales);
        xc = rad.*sin(0:0.1:(2*pi)) + pcols(j);
        yc = rad.*cos(0:0.1:(2*pi)) + prows(j);
        plot(yc, xc,'r');
    end
end

end


