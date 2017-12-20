function checkGradient(data, labels)
% Checking gradient for 9 random weights at each layer
%load('../data/nist26_train.mat')
classes = 26;
layers = [32*32, 400, classes];
[W, b] = InitializeNetwork(layers);
%data = train_data;
%labels = train_labels;

% Taking one training example
X = data(100,:)';
Y = labels(100,:)';
[~, act_h, act_a] = Forward(W, b, X);

% Calculate gradient for the randomly initialized W and b
[grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a);

% Looking at n*n random gradients
n = 3;
epsilon = 10^-4;

% Looking at n*n gradients at each layer
for i=1:length(W)
    W_i = W{i};
    rows = size(W_i,1);
    columns = size(W_i,2);
    % random rows and columns of W
    row_random = randi([1,rows],1,n);
    column_random = randi([1,columns],1,n);

    for r_idx=1:n
        for col_idx=1:n
            % Random indices
            j = row_random(r_idx);
            k = column_random(col_idx);
            e = zeros(size(W_i));
            % All but one index of e is non-zero
            e(j,k) = 1;
            % Incrementing just 1 element of W by epsilon
            W_i_plus = W_i+epsilon.*e;
            W_plus = W;
            W_plus{i} = W_i_plus;
            
            % Decrementing just 1 element of W by epsilon
            W_i_minus = W_i-epsilon.*e;
            W_minus = W;
            W_minus{i} = W_i_minus;
            
            % Finding loss at the 2 W's
            [~,J_plus] = ComputeAccuracyAndLoss(W_plus, b, X', Y');
            [~,J_minus] = ComputeAccuracyAndLoss(W_minus, b, X', Y');
            
            % Gradient from the approaximation
            approx_grad = (J_plus - J_minus)/(2*epsilon);
            %approx_grad = round(approx_grad, dec);
            
            % Actual gradient
            calc_grad = grad_W{i}(j,k);
            %calc_grad = round(calc_grad,dec);
            disp(approx_grad);
            disp(calc_grad);
            disp(calc_grad-approx_grad);
            diff = abs(calc_grad-approx_grad);
            assert(diff<10^-8, 'Gradients should be equal till 4 significant digits');   
        end
    end
end

end
