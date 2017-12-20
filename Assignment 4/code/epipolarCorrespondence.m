function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup
if size(im1,3)==3
    im1 = im2double(rgb2gray(im1));
end
if size(im2,3)==3
    im2 = im2double(rgb2gray(im2));
end
epipolar_line = F*[x1;y1;1];
a = epipolar_line(1);
b = epipolar_line(2);
c = epipolar_line(3);
win_size = 5;
% gaussian_weights = normrnd(0,1,win_size,win_size);
gaussian_weights = fspecial('gaussian', [win_size,win_size], 0.5);
% x_intercept = -epipolar_line(1)/epipolar_line(3);
% y_intercept = -epipolar_line(2)/epipolar_line(3);
height = size(im1,1);
width = size(im1,2);

range_check = 10;


y_start = y1-range_check;
y_end = y1+range_check;
if y1 <= range_check
    y_start = 1;
end
if y1 >= height-range_check
    y_end = width;
end



min_x = ceil(win_size/2);
% min_y = ceil(win_size/2);
max_x = width-ceil(win_size/2);
% max_y = height-ceil(win_size/2);

im1_window = im1(y1-floor(win_size/2):y1+floor(win_size/2),x1-floor(win_size/2):x1+floor(win_size/2));
% im1_window = cast(im1_window, 'like', 1.5);
im1_window_weighted = im1_window.*gaussian_weights;
min_dist = width;

for y=y_start:y_end
    
    x = round((-b*y-c)/a);
    if x< min_x
        continue;
    elseif x > max_x
        continue;
    end
    disp(x);
    disp(y);
    im2_window = im2(y-floor(win_size/2):y+floor(win_size/2),x-floor(win_size/2):x+floor(win_size/2));
%     im2_window = cast(im2_window, 'like', 1.5);
    im2_window_weighted = im2_window.*gaussian_weights;
    distance = pdist2(im1_window_weighted, im2_window_weighted);
    total_dist = sum(distance(:));
    if total_dist<min_dist
        min_dist = total_dist;
        x2 = x;
        y2 = y;
    end
    disp(total_dist);
    
end

end
