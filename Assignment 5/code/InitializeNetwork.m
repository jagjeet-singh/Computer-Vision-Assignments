function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

% Your code here
input_size = layers(1);
num_hidden_layers = size(layers,2)-2;
output_size = layers(end);
W = {};
b = {};
disp('## Initializing ##');
for i=1:size(layers, 2)-1
    %W_i = normrnd(0,0.1,layers(i+1),layers(i));
    W_i = -0.1 + 0.2*rand(layers(i+1),layers(i));
    b_i = zeros(layers(i+1),1);
    W{end+1} = W_i;
    b{end+1} = b_i;

end
C = size(b{end},1);
assert(size(W{1},2) == 1024, 'W{1} must be of size [H,N]');
assert(size(b{1},2) == 1, 'b{1} must be of size [H,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,H]');

end
