function findM2()

% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat

% Load data points
load('../data/some_corresp.mat');
p1 = pts1;
p2 = pts2;

% Calculate Camera matrices
I1 = imread('../data/im1.png');
load('../data/some_corresp.mat');
H = size(I1, 1);
W = size(I1, 2);
M = max(H,W);

% Load camera intrinsics K1 and K2
load('../data/intrinsics.mat');

% Find fundamental and essential matrices
F = eightpoint( p1, p2, M );
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

% Find 3D coordinates and error
[ P, err ] = triangulate( C1, p1, C2, p2 );

%save('q3_3.mat', 'M2', 'C2', 'p1', 'p2', 'P');

end