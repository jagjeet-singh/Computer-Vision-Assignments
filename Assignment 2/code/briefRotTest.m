% Script to test BRIEF under rotations
function chart = briefRotTest()

    im=imread('../data/model_chickenbroth.jpg');
    
    im = rgb2gray(im);
    im = im2double(im);
    
    angles = 0:10:360;
    matches = zeros(size(angles));
    for i=0:10:360
       
        im1 = imrotate(im,i);
        [~, desc1] = briefLite(im);
        [~, desc2] = briefLite(im1);
        [matches(i/10+1)] = size(briefMatch(desc1, desc2),1);
        
    end
    
    chart = bar(angles, matches);
end