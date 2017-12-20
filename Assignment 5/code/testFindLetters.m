function testFindLetters()
im={};    
im{1} = imread('../images/01_list.jpg');
im{2} = imread('../images/02_letters.jpg');
im{3} = imread('../images/03_haiku.jpg');
im{4} = imread('../images/04_deep.jpg');
input_im = im{4};
imshow(input_im);
hold on;
[lines, ~] = findLetters(input_im);
for j=1:size(lines,2)
    curr_line = lines{j};
    for k=1:size(curr_line,1)
        x_min = curr_line(k,1);
        y_min = curr_line(k,2);
        w = curr_line(k,3)-curr_line(k,1);
        h = curr_line(k,4)-curr_line(k,2);
        rectangle('Position',[x_min y_min w h]);
    end
end


end