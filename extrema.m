%/*
% * Developer : Prakriti Chintalapoodi - c.prakriti@gmail.com 
%*/

function extrema = extrema(top, current, down)
% Function to find the extrema keypoints given 3 matrices
% A pixel is a keypoint if it is the extremum of its 26 neighbors (8 in current, and 9 each in top and bottom)

[sx, sy] = size(current);

% Look for local maxima
% Check the 8 neighbors around the pixel in the same level

local_maxima = (current(2:sx-1,2:sy-1) > current(1:sx-2,1:sy-2)) & ...
               (current(2:sx-1,2:sy-1) > current(1:sx-2,2:sy-1)) & ...
               (current(2:sx-1,2:sy-1) > current(1:sx-2,3:sy)) & ...
               (current(2:sx-1,2:sy-1) > current(2:sx-1,1:sy-2)) & ...
               (current(2:sx-1,2:sy-1) > current(2:sx-1,3:sy)) & ...
               (current(2:sx-1,2:sy-1) > current(3:sx,1:sy-2)) & ...
               (current(2:sx-1,2:sy-1) > current(3:sx,2:sy-1)) & ...
               (current(2:sx-1,2:sy-1) > current(3:sx,3:sy));
      
% Check the 9 neighbors in the level above it
local_maxima = local_maxima & (current(2:sx-1,2:sy-1) > top(1:sx-2,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) > top(1:sx-2,2:sy-1)) & ...
                              (current(2:sx-1,2:sy-1) > top(1:sx-2,3:sy)) & ...
                              (current(2:sx-1,2:sy-1) > top(2:sx-1,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) > top(2:sx-1,2:sy-1)) & ...  % same pixel in top
                              (current(2:sx-1,2:sy-1) > top(2:sx-1,3:sy)) & ...
                              (current(2:sx-1,2:sy-1) > top(3:sx,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) > top(3:sx,2:sy-1)) & ...
                              (current(2:sx-1,2:sy-1) > top(3:sx,3:sy));        

% Check the 9 neighbors in the level below it                         
local_maxima = local_maxima & (current(2:sx-1,2:sy-1) > down(1:sx-2,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) > down(1:sx-2,2:sy-1)) & ...
                              (current(2:sx-1,2:sy-1) > down(1:sx-2,3:sy)) & ...
                              (current(2:sx-1,2:sy-1) > down(2:sx-1,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) > down(2:sx-1,2:sy-1)) & ...  % same pixel in down
                              (current(2:sx-1,2:sy-1) > down(2:sx-1,3:sy)) & ...
                              (current(2:sx-1,2:sy-1) > down(3:sx,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) > down(3:sx,2:sy-1)) & ...
                              (current(2:sx-1,2:sy-1) > down(3:sx,3:sy));
                          
% Look for local minima
% Check the 8 neighbors around the pixel in the same level
local_minima = (current(2:sx-1,2:sy-1) < current(1:sx-2,1:sy-2)) & ...
               (current(2:sx-1,2:sy-1) < current(1:sx-2,2:sy-1)) & ...
               (current(2:sx-1,2:sy-1) < current(1:sx-2,3:sy)) & ...
               (current(2:sx-1,2:sy-1) < current(2:sx-1,1:sy-2)) & ...
               (current(2:sx-1,2:sy-1) < current(2:sx-1,3:sy)) & ...
               (current(2:sx-1,2:sy-1) < current(3:sx,1:sy-2)) & ...
               (current(2:sx-1,2:sy-1) < current(3:sx,2:sy-1)) & ...
               (current(2:sx-1,2:sy-1) < current(3:sx,3:sy)) ;
      
% Check the 9 neighbors in the level above it
local_minima = local_minima & (current(2:sx-1,2:sy-1) < top(1:sx-2,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) < top(1:sx-2,2:sy-1)) & ...
                              (current(2:sx-1,2:sy-1) < top(1:sx-2,3:sy)) & ...
                              (current(2:sx-1,2:sy-1) < top(2:sx-1,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) < top(2:sx-1,2:sy-1)) & ...  % same pixel in top
                              (current(2:sx-1,2:sy-1) < top(2:sx-1,3:sy)) & ...
                              (current(2:sx-1,2:sy-1) < top(3:sx,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) < top(3:sx,2:sy-1)) & ...
                              (current(2:sx-1,2:sy-1) < top(3:sx,3:sy));        

% Check the 9 neighbors in the level below it                         
local_minima = local_minima & (current(2:sx-1,2:sy-1) < down(1:sx-2,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) < down(1:sx-2,2:sy-1)) & ...
                              (current(2:sx-1,2:sy-1) < down(1:sx-2,3:sy)) & ...
                              (current(2:sx-1,2:sy-1) < down(2:sx-1,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) < down(2:sx-1,2:sy-1)) & ...  % same pixel in down
                              (current(2:sx-1,2:sy-1) < down(2:sx-1,3:sy)) & ...
                              (current(2:sx-1,2:sy-1) < down(3:sx,1:sy-2)) & ...
                              (current(2:sx-1,2:sy-1) < down(3:sx,2:sy-1)) & ...
                              (current(2:sx-1,2:sy-1) < down(3:sx,3:sy));
                          
extrema_nonpad = local_maxima | local_minima;

extrema = zeros(size(current));
extrema(2:sx-1, 2:sy-1) = extrema_nonpad;

end







