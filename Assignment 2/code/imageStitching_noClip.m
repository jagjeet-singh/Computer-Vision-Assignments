function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image
nIter = 1000;
tol = 2;

img1 = imread('../data/incline_L.png');
img2 = imread('../data/incline_R.png');
% 
% img1 = im2double(rgb2gray(img1));
% img2 = im2double(rgb2gray(img2));

[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
[matches] = briefMatch(desc1, desc2);

H2to1 = ransacH(matches, locs1, locs2, nIter, tol);
% warp_im2 = warpH(img2, H2to1, [size(img1,1),size(img1,2)*2]);
% imshow(warp_im2);
% % 
x1_min = 1;
x1_max = size(img1,2);
y1_min = 1;
y1_max = size(img1,1);

top_left_1 = [x1_min; y1_min; 1];
top_right_1 = [x1_max; y1_min; 1];
bottom_left_1 = [x1_min; y1_max; 1];
bottom_right_1 = [x1_max; y1_max; 1];

x2_min = 1;
x2_max = size(img2,2);
y2_min = 1;
y2_max = size(img2,1);

top_left_2 = H2to1*[x2_min;y2_min;1];
top_right_2 = H2to1*[x2_max;y2_min;1];
bottom_left_2 = H2to1*[x2_min;y2_max;1];
bottom_right_2 = H2to1*[x2_max;y2_max;1];

actual_width = 1056;

min_x = min([top_left_1(1),top_left_2(1),bottom_left_1(1),bottom_left_2(1)]);
max_x = max([top_right_1(1),top_right_2(1),bottom_right_1(1),bottom_right_2(1)]);
min_y = min([top_left_1(2),top_left_2(2),top_right_1(2),top_right_2(2)]);
max_y = max([bottom_left_1(2),bottom_left_2(2),bottom_right_1(2),bottom_right_2(2)]);

min_width = max_x - min_x;
min_height = max_y - min_y;

aspect_ratio = min_width/min_height;
actual_height = ceil(actual_width/aspect_ratio);

% scale = min_height/actual_height;
scale = actual_height/min_height;

M = [1,0,-min_x*2;0,1,-min_y*2;0,0,scale];
warp_im1 = warpH(img1, M,[floor(actual_height*1.27),floor(actual_width*1.62)]);
warp_im2 = warpH(img2, M*H2to1,[floor(actual_height*1.27),floor(actual_width*1.62)]);


% warp_im1 = warpH(img1, M,[floor(actual_height*1.5),actual_width*2]);
% warp_im2 = warpH(img2, M*H2to1,[floor(actual_height*1.5),actual_width*2]);
% panoImg = warp_im1./2+warp_im2./2;
panoImg = max(warp_im1,warp_im2);
end
% imshow(warp_im1./2+warp_im2./2);

