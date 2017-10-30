function testMatch()
    
    im1=imread('../data/model_chickenbroth.jpg');
    
    if size(im1,3)==3
        im1 = rgb2gray(im1);
    end
    im1 = im2double(im1);
    
%     im2 = imrotate(im1,90);
    im2=imread('../data/chickenbroth_01.jpg');
    if size(im2,3)==3
        im2 = rgb2gray(im2);
    end
    im2 = im2double(im2);
    
    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);
    
    [matches] = briefMatch(desc1, desc2);
    
    plotMatches(im1, im2, matches, locs1, locs2);

end