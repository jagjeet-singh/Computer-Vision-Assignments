function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.

locsDoG = [];

% h = size(DoGPyramid,1);
% w = size(DoGPyramid,2);
% l = size(DoGPyramid,3);

% DoGPyramid_padded = padarray(DoGPyramid,[1,1,1]);
DoGPyramid_padded = padarray(DoGPyramid,[1,1,1],'replicate');
% DoGPyramid_padded = DoGPyramid;
h = size(DoGPyramid_padded,1);
w = size(DoGPyramid_padded,2);
l = size(DoGPyramid_padded,3);

for i = 2:l-1
  
  
    A = DoGPyramid_padded(2:h-1,2:w-1,i);
    A1 = DoGPyramid_padded(1:h-2,2:w-1,i);
    A2 = DoGPyramid_padded(3:h,2:w-1,i); 
    A3 = DoGPyramid_padded(2:h-1,1:w-2,i);
    A4 = DoGPyramid_padded(2:h-1,3:w,i);
    A5 = DoGPyramid_padded(3:h,3:w,i);
    A6 = DoGPyramid_padded(3:h,1:w-2,i);
    A7 = DoGPyramid_padded(1:h-2,3:w,i);
    A8 = DoGPyramid_padded(1:h-2,1:w-2,i);
    A9 = DoGPyramid_padded(2:h-1,2:w-1,i-1);
    A10 = DoGPyramid_padded(2:h-1,2:w-1,i+1);
    loc_max = ((A-A1)>=0&(A-A2)>=0&(A-A3)>=0&(A-A4)>=0&(A-A5)>=0&(A-A6)>=0&(A-A7)>=0&(A-A8)>=0&(A-A9)>=0&(A-A10)>=0);
    loc_min = ((A-A1)<=0&(A-A2)<=0&(A-A3)<=0&(A-A4)<=0&(A-A5)<=0&(A-A6)<=0&(A-A7)<=0&(A-A8)<=0&(A-A9)<=0&(A-A10)<=0);
%     loc_max = ((A-A1)>0&(A-A2)>0&(A-A3)>0&(A-A4)>0&(A-A5)>0&(A-A6)>0&(A-A7)>0&(A-A8)>0&(A-A9)>0&(A-A10)>0);
%     loc_min = ((A-A1)<0&(A-A2)<0&(A-A3)<0&(A-A4)<0&(A-A5)<0&(A-A6)<0&(A-A7)<0&(A-A8)<0&(A-A9)<0&(A-A10)<0);

    loc_ext = loc_max | loc_min;
    dog = loc_ext & (abs(A)>th_contrast);
%     dog = loc_ext & (abs(A)>th_contrast);

	pr = PrincipalCurvature(:,:,i-1)>=0 & PrincipalCurvature(:,:,i-1)<th_r;
%     pr = PrincipalCurvature(2:h-1,2:w-1,i)>=0 & PrincipalCurvature(2:h-1,2:w-1,i)<th_r;

	result = dog & pr;
	[y, x] = ind2sub(size(result),find(result==1));
    l = (i-1)*ones(size(y));
	locsDoG = [locsDoG;[x,y,l]];
	 

end

    




    
    
    
    