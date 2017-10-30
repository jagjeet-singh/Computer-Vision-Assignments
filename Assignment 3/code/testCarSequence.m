function testCarSequence ()

load('../data/carseq.mat');
x1 = 60;
y1 = 117;
x2 = 146;
y2 = 152;

%% Displaying at frames 1,100,200,300,400

num_frames = size(frames,3);
rects = zeros(num_frames,4); 
for i=1:num_frames-1
    disp(i);
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);

    rect = [x1,y1,x2,y2]';
    rects(i,:) = rect';

    if (mod(i,100)==0) || (i==1)
        subplot(1,5,i/100+1);
        imshow(It);
        title(strcat({'Frame: '}, string(i)));
        hold on
        rectangle('Position', [x1,y1,x2-x1,y2-y1],'EdgeColor','y');
    end
    
    [px,py] = LucasKanade(It, It1, rect);
    x1 = x1+px;
    x2 = x2+px;
    y1 = y1+py;
    y2 = y2+py;
    
rect = [x1,y1,x2,y2]';
rects(i+1,:) = rect';

% save('carseqrects.mat', 'rects');

end

end