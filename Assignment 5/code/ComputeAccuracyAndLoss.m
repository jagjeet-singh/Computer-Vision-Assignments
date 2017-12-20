function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.
% data DxN
% labels DxC
[~,N] = size(data);
[~,C] = size(labels);
assert(size(W{1},2) == N, 'W{1} must be of size [~,N]');
assert(size(b{1},2) == 1, 'b{1} must be of size [~,1]');
assert(size(b{end},2) == 1, 'b{end} must be of size [~,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,~]');

prob = Classify(W,b,data); % DxC
[~,pred_label] = max(prob,[],2);
[~, ground_truth] = max(labels,[],2);
accuracy = sum(pred_label==ground_truth)*100/numel(ground_truth);
loss = 0;
for i = 1:size(ground_truth)
    loss = loss + (-log(prob(i,ground_truth(i))));
end
loss = loss/numel(ground_truth);
end
