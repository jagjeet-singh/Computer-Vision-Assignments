function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary
patchWidth = 9;
halfPatch = floor(patchWidth/2);
desc = [];
locs = [];

[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);

for i=1:size(locsDoG,1)
    keyPoint_x = locsDoG(i,1);
    keyPoint_y = locsDoG(i,2);
    layer = locsDoG(i,3);
    if (keyPoint_x>halfPatch && keyPoint_x<=(size(im,2)-halfPatch) && keyPoint_y>halfPatch && keyPoint_y<=(size(im,1)-halfPatch))
        locs = [locs;locsDoG(i,:)];
        patch = im((keyPoint_y-halfPatch):(keyPoint_y+halfPatch),(keyPoint_x-halfPatch):(keyPoint_x+halfPatch));
%         patch = GaussianPyramid((keyPoint_y-halfPatch):(keyPoint_y+halfPatch),(keyPoint_x-halfPatch):(keyPoint_x+halfPatch),layer);
        desc_i = patch(compareB)<patch(compareA);
            
        desc = [desc; desc_i'];
    end
    
end

disp('image computed');
end