function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'
N = size(X,1);
H = size(W{1},1);
C = size(b{end},1);
assert(size(W{1},2) == N, 'W{1} must be of size [H,N]');
assert(size(b{1},2) == 1, 'W{end} must be of size [H,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,H]');
assert(all(size(act_a{1}) == [H,1]), 'act_a{1} must be of size [H,1]');
assert(all(size(act_h{end}) == [C,1]), 'act_h{end} must be of size [C,1]');
%disp('##########Backward')
out_h = act_h{end};
out_a = act_a{end};

%one_hot_Y = zeros(C,1);
%one_hot_Y(Y) = 1;
grad_out_h = (-1./out_h).*Y;
grad_out_h_wrt_out_a = zeros(C,C);
for i=1:C
    for j=1:C
        if i==j
            grad_out_h_wrt_out_a(i,j) = out_h(i)*(1-out_h(i));
        else
            grad_out_h_wrt_out_a(i,j) = -out_h(i)*out_h(j);
        end
    end
end
grad_out_a = grad_out_h_wrt_out_a*grad_out_h;

num_hidden = length(W)-1;
grad_a_next = grad_out_a; % Cx1
grad_W = {};
grad_b = {};
for i=num_hidden:-1:1
    hidden_i_h = act_h{i}; % Hx1
    hidden_i_a = act_a{i}; % Hx1
    W_i = W{i+1}; % CxH
    grad_hidden_h_i = W_i'*grad_a_next; % Hx1
    grad_W_i = grad_a_next*hidden_i_h'; % CxH
    grad_b_i = grad_a_next; % Cx1
    grad_hidden_a_i = grad_hidden_h_i.*hidden_i_h.*(1-hidden_i_h);
    grad_a_next = grad_hidden_a_i; % Hx1
    grad_W = [{grad_W_i},grad_W]; 
    grad_b = [{grad_b_i},grad_b];
end

grad_W_1 = grad_a_next*X'; % HxN
grad_b_1 = grad_a_next; % Hx1
grad_W = [{grad_W_1},grad_W]; 
grad_b = [{grad_b_1},grad_b];

assert(size(grad_W{1},2) == N, 'grad_W{1} must be of size [H,N]');
assert(size(grad_W{end},1) == C, 'grad_W{end} must be of size [C,N]');
assert(size(grad_b{1},1) == H, 'grad_b{1} must be of size [H,1]');
assert(size(grad_b{end},1) == C, 'grad_b{end} must be of size [C,1]');

end
