function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
%%Produces DoG Pyramid
% inputs
% Gaussian Pyramid - A matrix of grayscale images of size
%                    (size(im), numel(levels))
% levels      - the levels of the pyramid where the blur at each level is
%               outputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%               created by differencing the Gaussian Pyramid input

h = size(GaussianPyramid,1);
w = size(GaussianPyramid,2);
DoGLevels = levels(:,2:end);

DoGPyramid = im2double(zeros(h,w,size(DoGLevels,2)));


for i=1:(size(DoGLevels,2))

   
    DoGPyramid(:,:,i) = GaussianPyramid(:,:,i+1)-GaussianPyramid(:,:,i); 
      
end