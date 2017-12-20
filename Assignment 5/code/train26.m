num_epoch = 30;
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.001;

load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

[W, b] = InitializeNetwork(layers);
x_axis = 1:num_epoch;
train_accuracy = zeros(num_epoch);
valid_accuracy = zeros(num_epoch);
train_err = zeros(num_epoch);
valid_err = zeros(num_epoch);

for j = 1:num_epoch
    % train_data 7800x1024
    % train_labels 7800x26
    idx = randperm(size(train_data,1));
    train_data = train_data(idx,:);
    train_labels = train_labels(idx,:);
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);
    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    train_accuracy(j) = train_acc;
    valid_accuracy(j) = valid_acc;
    train_err(j) = train_loss;
    valid_err(j) = valid_loss;
    %disp(train_acc);
    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss);
end

plot(x_axis, train_accuracy, x_axis, valid_accuracy);
ylim([0,100])
legend('Train','Validation')
title('Training and Validation Accuracy for lr=0.001')
xlabel('Epoch')
ylabel('Accuracy')

plot(x_axis, train_err, x_axis, valid_err);
%ylim([0,100])
legend('Train','Validation')
title('Training and Validation Loss for lr=0.01')
xlabel('Epoch')
ylabel('Loss')

save('nist26_acc_loss_lr001.mat', 'train_accuracy', 'valid_accuracy', 'train_err', 'valid_err');
save('nist26_model_lr001.mat', 'W', 'b')
