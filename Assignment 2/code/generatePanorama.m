function im3 = generatePanorama(im1,im2)

nIter = 1000;
tol = 2;

if size(im1,3)==3
    img1 = rgb2gray(im1);
end

if size(im2,3)==3
    img2 = rgb2gray(im2);
end
img1 = im2double(img1);
img2 = im2double(img2);

[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);

[matches] = briefMatch(desc1, desc2);

H2to1 = ransacH(matches, locs1, locs2, nIter, tol);

im3 = imageStitching_noClip(im1, im2, H2to1);

end