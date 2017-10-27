function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)
    height = size(wordMap,1);
    width = size(wordMap,2);
    L = layerNum-1;
    h=[];
    for l=L:-1:0
        for i=0:2^l-1 
            for j=0:2^l-1
                if l==0 || l==1
                    weight = 2^(-L);
                else
                    weight = 2^(l-L-1);
                end
                cell_h_start = floor(((height/2^l)*i)+1);
                cell_h_end = floor((height/2^l)*(i+1));
                cell_w_start = floor((width/2^l)*j+1);
                cell_w_end = floor((width/2^l)*(j+1));
                h =[h;(weight/(2^(2*l))).*getImageFeatures(wordMap(cell_h_start:cell_h_end,cell_w_start:cell_w_end),dictionarySize)];
                
            end
        end 
    end
    

    % TODO Implement your code here


end