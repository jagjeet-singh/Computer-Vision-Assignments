function [W, b] = Train(W, b, train_data, train_label, learning_rate)
% [W, b] = Train(W, b, train_data, train_label, learning_rate) trains the network
% for one epoch on the input training data 'train_data' and 'train_label'. This
% function should returned the updated network parameters 'W' and 'b' after
% performing backprop on every data sample.
[~,N] = size(train_data);
[~,C] = size(train_label);
assert(size(W{1},2) == N, 'W{1} must be of size [~,N]');
assert(size(b{1},2) == 1, 'b{1} must be of size [~,1]');
assert(size(b{end},2) == 1, 'b{end} must be of size [~,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,~]');

% This loop template simply prints the loop status in a non-verbose way.
% Feel free to use it or discard it


for i = 1:size(train_data,1)

    X = train_data(i,:); % X : 1xN
    Y = train_label(i,:);
    [~, act_h, act_a] = Forward(W, b, X');
    [grad_W, grad_b] = Backward(W, b, X', Y', act_h, act_a);
    [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);
    %disp(W{1}(1:10));

    if mod(i, 100) == 0
        %fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')
        fprintf('Done %.2f %% \n', i/size(train_data,1)*100)
    end
end
%fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')


end
