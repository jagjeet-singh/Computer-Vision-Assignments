function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();
    filterBank_size = size(filterBank);
    no_of_filters = filterBank_size(1);
    alpha=50;
    K = 100;
    % TODO Implement your code here
    filter_responses = zeros(alpha*length(imPaths),3*no_of_filters);
    for i=1:length(imPaths)
        img = imread(imPaths{i});
        filter_response_all_pixels = extractFilterResponses(img, filterBank);
        
        m=size(filter_response_all_pixels,1);
        n=size(filter_response_all_pixels,2);
        f=size(filter_response_all_pixels,3);
        filter_response_flat = reshape(filter_response_all_pixels,[m*n,f]);
        sample_pixels = randperm(m*n,alpha);
        filter_response_sample = filter_response_flat(sample_pixels,:);
        filter_responses(alpha*(i-1)+1:i*alpha,:) = filter_response_sample;
    end
    [~,dictionary] = kmeans(filter_responses,K,'EmptyAction','drop');
%     dictionary = dictionary_row';
end
