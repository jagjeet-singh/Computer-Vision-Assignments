% Your code here.

fname={'../images/01_list.jpg', '../images/02_letters.jpg', '../images/03_haiku.jpg', '../images/04_deep.jpg'};
text = {};
for i=1:size(fname,2)

    text{i}=extractImageText(fname{i});
    disp(text{i});

end
