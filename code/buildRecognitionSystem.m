function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    train_wordMap = strrep(train_imagenames,'.jpg','.mat');
    K = size(dictionary,1);
    N = size(train_imagenames,1);
    layerNum = 3;
    L=layerNum-1;
    train_features=zeros(K*(4^(L+1)-1)/3,N);
    for i=1:size(train_wordMap,1)
        wordMap_struct=load(strcat('../data/',train_wordMap{i}));
        wordMap_cell = struct2cell(wordMap_struct);
        wordMap = cell2mat(wordMap_cell);
        train_features(:,i)=getImageFeaturesSPM(layerNum, wordMap, K);
    end
    
%     train_label_word = strings(1,size(train_labels,1));
%     for i=1:size(train_labels,1)
%         train_label_word(i)=mapping{train_labels(i)};
%     end
%     
%     train_labels = train_label_word;
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end