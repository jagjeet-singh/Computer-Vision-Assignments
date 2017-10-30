function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image
% nIter = 1000;
% tol = 2;
% 
% img1 = imread('../data/incline_L.png');
% img2 = imread('../data/incline_R.png');
% 
% [locs1, desc1] = briefLite(img1);
% [locs2, desc2] = briefLite(img2);
% 
% [matches] = briefMatch(desc1, desc2);
% 
% H2to1 = ransacH(matches, locs1, locs2, nIter, tol);
% 
warp_img2 = warpH(img2, H2to1, [size(img1,1),ceil(size(img1,2))]);
% panoImg = 0.5.*img1+0.5.*warp_img2;
panoImg = max(img1,warp_img2);
% imshow(panoImg)
imwrite(panoImg, '../results/6_1_v2.jpg');
end
