function visualize()

load('q4_1.mat');
pts1 = load('../data/templeCoords.mat');
x1 = pts1.x1;
y1 = pts1.y1;
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
x2 = zeros(size(x1));
y2 = zeros(size(y1));
for i=1:size(x1,1)
    [ x2(i), y2(i) ] = epipolarCorrespondence( im1, im2, F, x1(i), y1(i));
end
p1 = [x1,y1];
p2 = [x2,y2];

% Finding C1, C2
H = size(im1, 1);
W = size(im1, 2);
M = max(H,W);

% Load camera intrinsics K1 and K2
load('../data/intrinsics.mat');

% Find fundamental and essential matrices
E = essentialMatrix( F, K1, K2 );
[M2s] = camera2(E);

% M1 from Canonical camera extrinsics
M1 = [1,0,0,0;
      0,1,0,0;
      0,0,1,0];

% Pick one of the 4 M2s
M2 = findBestM2(M2s, K1, K2, M1, p1, p2);
C1 = K1*M1;
C2 = K2*M2;

[ P, err ] = triangulate( C1, p1, C2, p2 );
scatter3(P(:,1),P(:,2),P(:,3),'filled');

% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

%save('q4_2.mat', 'F', 'M1', 'M2', 'C1', 'C2');

end