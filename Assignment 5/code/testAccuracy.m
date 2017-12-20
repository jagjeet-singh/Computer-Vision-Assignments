load('nist26_model_lr01.mat')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
[outputs] = Classify(W, b, test_data);
[~, pred] = max(outputs,[],2);
pred_one_hot = zeros(size(outputs));
for i=1:size(pred)
    pred_one_hot(i,pred(i)) = 1;
end
[~, truth]= max(test_labels, [],2);
[test_acc, test_loss] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);
confusion=zeros(26,26);
for i=1:size(pred)
    confusion(pred(i),truth(i))=confusion(pred(i),truth(i))+1;
end

plotconfusion(test_labels,pred_one_hot);
%heatmap(confusion, labels, 1:26, 1,'Colormap','red','ShowAllTicks',1,'UseLogColorMap',true,'Colorbar',true);