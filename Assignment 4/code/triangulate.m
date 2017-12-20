function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q3.2:
%       Implement a triangulation algorithm to compute the 3d locations
%

% Load data points
if ~exist('p1','var')
    load('../data/some_corresp.mat');
    p1 = pts1;
    p2 = pts2;
end

% Calculate Camera matrices
if ~exist('C1','var') || ~exist('C2','var')
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
end
    
num_cor = size(p1,1);
P = zeros(num_cor,3);
err = 0;
for i = 1:num_cor
    x1 = p1(i,1);
    y1 = p1(i,2);
    x2 = p2(i,1);
    y2 = p2(i,2);
    
    % Matrix for homogenous equation
    A = [x1.*C1(3,:) - C1(1,:);
         y1.*C1(3,:) - C1(2,:);
         x2.*C2(3,:) - C2(1,:);
         y2.*C2(3,:) - C2(2,:);];
     
     [~,~,V] = svd(A);
     
     % 3D coordinates
     P_unnormamized = V(:,end);
     P_normalized = P_unnormamized./P_unnormamized(4);
     P(i,:) = P_normalized(1:3); 
     % Reprojecting to 2D image
     p1_pred = C1*P_normalized;
     p1_pred = p1_pred./p1_pred(3);
     p2_pred = C2*P_normalized;
     p2_pred = p2_pred./p2_pred(3);
     
     % Reprojection error
     err = err + norm(p1(i,1:2)-p1_pred(1:2)')+norm(p2(i,1:2)-p2_pred(1:2)');
     %disp(err);
     %disp(p1_pred);
     %disp(p2_pred);
    
end
disp(P)
%save('q3_3.mat', 'M2', 'C2', 'p1', 'p2', 'P')


end
