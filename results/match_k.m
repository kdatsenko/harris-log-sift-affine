function [k_matches_im1, k_matches_im2, size_match_array] = match_k(d_im1, d_im2, k)

% find euclidean distances between each pair of observations 
% rows of each input matrix correspond to observations (transpose)
% (i,j) D entry equal to distance between observation 
% i in X and observation j in Y
D = pdist2(d_im1.', d_im2.');
[n, ~] = size(D);

%thres ratio of nearest / 2nd nearest neighbour (should be < 0.8)
threshold = 0.8; 

%find closest match (to one vector in test img)
%find second closest match
%match reliable if first dist much smaller than second

% calculate ratios and closest matches
%if A is a matrix, then sort(A,2) sorts the elements in each row
%sort(any i, j_fixed)
[D_rows_sorted, I] = sort(D, 2);
matches = zeros(1, n);

%index is feature in ref img, value is feature in second img
match_scores = zeros(1, n); 

for i=1:n %each row - fix i (ref img), change j (second img)
    %closest/second_closest dist in that row
    ratio = D_rows_sorted(i,1) / D_rows_sorted(i,2);
    if ratio < threshold %check if match reliable, otherwise no match
        matches(i) = I(i, 1); %index of first closest
        match_scores(i) = ratio;
    else
        match_scores(i) = Inf;
        matches(i) = -1;
    end
end
  
% get top k correspondences 
%choose matches with k smallest score (ratio) values
[~, score_index] = sort(match_scores);
k_matches_im1 = zeros(1, k);
k_matches_im2 = zeros(1, k);
size_match_array = 0;
for i = 1:k
    ith_smallest_index = score_index(i); %only 1 row
    if (isinf(match_scores(ith_smallest_index)))
        break;
    end
    k_matches_im1(i) = ith_smallest_index;
    k_matches_im2(i) = matches(ith_smallest_index);
    size_match_array = size_match_array + 1;
end

end