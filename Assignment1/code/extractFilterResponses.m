function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here
cast(img,'like',1.1)
if ismatrix(img)
    img_lab = repmat(img,[1,1,3]);
else
    img_lab=RGB2Lab(img);
end

im_size=size(img_lab);

filter_size = size(filterBank);
response = zeros(im_size(1),im_size(2),im_size(3)*filter_size(1));
response_multi_frame = zeros(im_size(1),im_size(2),im_size(3),filter_size(1));

for filter_iter=1:filter_size(1)
    curr_filter = filterBank{filter_iter};
    response(:,:,3*filter_iter-2:3*filter_iter)=imfilter(img_lab,curr_filter,'replicate');
    response_multi_frame(:,:,:,filter_iter)=imfilter(img_lab,curr_filter,'replicate');
end

% montage(response_multi_frame,'Size',[4 5]);
filterResponses = response;





