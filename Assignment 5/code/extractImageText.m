function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the text contained in the image as a string.
text = '';
classes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
%fname = '../images/01_list.jpg';
im = imread(fname);
[lines,bw] = findLetters(im);
load('nist36_model_lr01.mat');
for i=1:size(lines,2)
    curr_line = lines{i};
    is_noise = 1;
    for j=1:size(curr_line,1)
        x1 = round(curr_line(j,1));
        if j>1 && x1-x2>90
            text = [text ' '];
        end
        y1 = round(curr_line(j,2));
        x2 = round(curr_line(j,3));
        y2 = round(curr_line(j,4));
        if (x2-x1)*(y2-y1)>100
            is_noise = 0;
            input = bw(y1:y2,x1:x2);
            input = padarray(input,[20,20],1);
            data = imresize(input,[32,32]);
            data = reshape(data, [1,32*32]);
            [outputs] = Classify(W, b, data);
            [~, idx] = max(outputs);
            letter = classes(idx);
            text = [text letter];
        end
    end
    if is_noise==0
        text = [text newline];
    end
end
