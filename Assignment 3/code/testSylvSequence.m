function testSylvSequence()

load('../data/sylvseq.mat');
load('../data/sylvbases.mat');
x1 = 102;
y1 = 62;
x2 = 156;
y2 = 108;

%% Displaying Normal Lucas Kanade at frames 1,200,300,350,400
num_frames = size(frames,3);
rects = zeros(num_frames,4); 
for i=1:num_frames-1
    disp(i);
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);

    rect = [x1,y1,x2,y2]';
    rects(i,:) = rect';

    if i==1 || i==200 || i==300 || i==350 || i==400
        if i==1
            subplot(1,5,1);
        end
        if i==200
            subplot(1,5,2);
        end
        if i==300
            subplot(1,5,3);
        end
        if i==350
            subplot(1,5,4);
        end
        if i==400
            subplot(1,5,5);
        end
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

% save('careseqrects.mat', 'rects');

end



%% Displaying Lucas Kanade with Basis at frames 1,200,300,350,400

x1 = 102;
y1 = 62;
x2 = 156;
y2 = 108;

num_frames = size(frames,3);
rects = zeros(num_frames,4); 
for i=1:num_frames-1
    disp(i);
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);

    rect = [x1,y1,x2,y2]';
    rects(i,:) = rect';

    if i==1 || i==200 || i==300 || i==350 || i==400
        if i==1
            subplot(1,5,1);
        end
        if i==200
            subplot(1,5,2);
        end
        if i==300
            subplot(1,5,3);
        end
        if i==350
            subplot(1,5,4);
        end
        if i==400
            subplot(1,5,5);
        end
%         imshow(It);
%         title(strcat({'Frame: '}, string(i)));
%         hold on
        rectangle('Position', [x1,y1,x2-x1,y2-y1],'EdgeColor','b');
    end
    
    [px,py] = LucasKanadeBasis(It, It1, rect, bases);
%     [px,py] = LucasKanade(It, It1, rect);
    x1 = x1+px;
    x2 = x2+px;
    y1 = y1+py;
    y2 = y2+py;
    
rect = [x1,y1,x2,y2]';
rects(i+1,:) = rect';

save('sylvseqrects.mat', 'rects');

end

end