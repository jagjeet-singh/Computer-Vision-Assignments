function [compareA, compareB] = makeTestPattern(patchWidth, nbits) 
%%Creates Test Pattern for BRIEF
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and
% save the results in testPattern.mat.
%
% INPUTS
% patchWidth - the width of the image patch (usually 9)
% nbits      - the number of tests n in the BRIEF descriptor
%
% OUTPUTS
% compareA and compareB - LINEAR indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors. 

% compareA = normrnd(5, (patchWidth)/5, [nbits,1]);
% compareA=floor(compareA);
% compareA = compareA.*9;
% compareB = normrnd(5, (patchWidth)/5, [nbits,1]);
% compareB=floor(compareB);
% compareB = compareB.*9;
% 
% for i=1:nbits
% 
%     if(compareA(i)<1)
%         compareA(i) = 1; 
%     end
%     
%     if(compareB(i)<1)
%         compareB(i) = 1; 
%     end
%     
%     if(compareA(i)>81)
%         compareA(i) = 81; 
%     end
%     if(compareB(i)>81)
%         compareB(i) = 81; 
%     end
% 
% end

compareA = randi([1,81],[nbits,1]);
compareB = randi([1,81],[nbits,1]);

save('testPattern.mat', 'compareA', 'compareB');