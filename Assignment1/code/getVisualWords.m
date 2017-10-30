function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
        dictionary = dictionary';
        img_filtered = extractFilterResponses(img, filterBank);
        
        h=size(img_filtered,1);
        w=size(img_filtered,2);
        f=size(img_filtered,3);
        image_filtered_flat = reshape(img_filtered,[w*h,f]);
        distances = pdist2(image_filtered_flat,dictionary);
        [~,min_index] = min(distances,[],2);
        wordMap = reshape(min_index,[h w]);
        
     
end
