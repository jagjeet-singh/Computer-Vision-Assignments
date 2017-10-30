function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

outsize = size(image1);

% warped_image2 = zeros(outsize);
W = LucasKanadeAffine(image1, image2);

threshold = 70;

 warp_It = warpH(image1, W, outsize);
% 
% for i = 1:outsize(1)
%         for j = 1:outsize(2)
%             warped_coord = W*[j,i,1]';
%             warped_x = warped_coord(1);
%             warped_y = warped_coord(2);
%             if(warped_x>=1 && warped_x<=outsize(2) && warped_y>=1 && warped_y<=outsize(1))
%                 warped_image2(floor(warped_y), floor(warped_x)) = image2(floor(warped_y),floor(warped_x));
%             end
%         end
% end

diff = abs(image2 - warp_It);
level = graythresh(diff);

%
mask = imbinarize(diff,level);

[r,c] = find(mask==1);
% %% im not sure about this stuff
SE_d = strel('sphere', 9);
SE_e = strel('disk', 8);
mask = imdilate(mask, SE_d);
mask = imerode(mask, SE_e);
mask = bwselect(mask, c, r, 8);
mask = mask - bwareaopen(mask, 400);
% 
% binary = abs(image2-warp_It)>threshold;
% SE = strel('sphere',7);
% im_dilated = imdilate(binary,SE);
% [r,c] = find(binary==1);
% % image2_binary = imbinarize(image2);
% image2_stationary_objects = bwselect(im_dilated, c, r, 8);
% % image2_stationary_objects = imdilate(image2_stationary_objects, 0);
% mask = image2_stationary_objects;
end



