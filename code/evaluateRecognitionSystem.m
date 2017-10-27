function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
    
   y_hat = zeros(size(test_labels)); 
   y_truth = test_labels;
   conf = zeros(size(mapping,2),size(mapping,2));
   for i=1:size(test_labels,1)
       guessed_image = guessImage(strcat('../data/',test_imagenames{i}));
       for j=1:size(mapping,2)
           if(string(mapping{j})==string(guessed_image))
               y_hat(i)=j;
       
           end
       end
       y_truth(i)
       y_hat(i)    
       conf(y_truth(i),y_hat(i))=conf(y_truth(i),y_hat(i))+1;
    end
   
   
   
   
   
   

end