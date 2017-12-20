function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

% Left image points
x1 = pts1(:,1);
y1 = pts1(:,2);

% Right image points
x2 = pts2(:,1);
y2 = pts2(:,2);

% Normalizing matrix
T = [1/M, 0, 0; 0, 1/M, 0; 0, 0, 1];

% Normalizing coordinates in left and right image 
x1 = x1./M;
x2 = x2./M;
y1 = y1./M;
y2 = y2./M;

% Coefficient matrix
one = ones(size(x1));
U = [x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, one];

%F is the eigent vector corresponding to the smallest eigen value of U
[~,~,V] = svd(U);

F = reshape(V(:,end),[3,3]);
% F = F./norm(F);

% Rank 2 constraint
[A,B,C] = svd(F);
B(3,3) = 0;
F = A*B*C';

% Denormalizing 
F = T'*F*T;

% Refining F
F = refineF(F, pts1, pts2);

% F = F./M;
end

