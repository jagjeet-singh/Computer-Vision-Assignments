function testCarSequenceWithTemplateCorrection()

load('../data/carseq.mat');
x1 = 60;
y1 = 117;
x2 = 146;
y2 = 152;

%% Displaying at frames 1,100,200,300,400 without template correction
testCarSequence();


%% Displaying at frames 100,200,300,400 with template correction

num_frames = size(frames,3);
rects = zeros(num_frames,4); 
I_firstframe = frames(:,:,1);
rect1 = [x1,y1,x2,y2]';

rect = rect1;
rects = zeros(num_frames,4); 
for i=1:num_frames-1
    disp(i);
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    x1 = rect(1);
    y1 = rect(2);
    x2 = rect(3);
    y2 = rect(4);
    rects(i,:) = rect';
    
    [px,py] = LucasKanade(It, It1, rect);
    
    x1_temp = x1+px;
    x2_temp = x2+px;
    y1_temp = y1+py;
    y2_temp = y2+py;
    p_n = [px,py]';
    rect_temp = [x1_temp,y1_temp,x2_temp,y2_temp]';
    
    %It1 in the next line is Itn
    [px_star,py_star] = LucasKanade_1_to_n(I_firstframe, It1, p_n, rect1, rect_temp);

    rect = [x1_temp+px_star, y1_temp+py_star,x2_temp+px_star, y2_temp+py_star]';
    if (mod(i,100)==99)
        subplot(1,5,floor(i/100)+2);
        title(strcat({'Frame: '}, string(i+1)));
        rectangle('Position', [rect(1),rect(2),rect(3)-rect(1),rect(4)-rect(2)],'EdgeColor','b');
    end

rects(i+1,:) = rect';

% save('carseqrects-wcrt.mat', 'rects');

end

end