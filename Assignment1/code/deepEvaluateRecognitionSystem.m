function [conf] = deepEvaluateRecognitionSystem(net)

    load('../data/traintest.mat');
    load('../data/fc7_training.mat');
%     net=vgg16();
    
    y_hat = zeros(size(test_labels)); 
    y_truth = test_labels;
    conf = zeros(size(mapping,2),size(mapping,2));
    
%     for i=1:size(test_labels,1)
    for i=1:10:100
        disp('iter');
        disp(i);
        im = imread(strcat('../data/',test_imagenames{i}));
        test_feature = extractDeepFeatures(net, im);
        diff = test_feature'-fc7_training;
        diff_sqr = (test_feature'-fc7_training).^2;
        eucl_dist = sum((test_feature'-fc7_training).^2,2);
        [~,argmin] = min(cast(eucl_dist,'like',1.1));
%         y_truth(i) = train_labels(argmin);
        y_hat(i) = train_labels(argmin);    
        conf(y_truth(i),y_hat(i))=conf(y_truth(i),y_hat(i))+1;
    end
    disp(conf);

end