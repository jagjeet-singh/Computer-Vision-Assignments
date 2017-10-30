function testAerialSequence()

load('../data/aerialseq.mat');

%% Displaying results at frames 30, 60, 90, 120

num_frames = size(frames,3);

for i=1:num_frames-1
    disp(i);
    if i==30 || i==60 || i==90 || i==120
        if i==30
            subplot(1,4,1);
        end
        if i==60
            subplot(1,4,2);
        end
        if i==90
            subplot(1,4,3);
        end
        if i==120
            subplot(1,4,4);
        end
        image1 = frames(:,:,i);
        image2 = frames(:,:,i+1);
        mask = SubtractDominantMotion(image1, image2);
        title(strcat({'Frame: '}, string(i)));
        imshow(imfuse(image1, mask));
    end

end

end