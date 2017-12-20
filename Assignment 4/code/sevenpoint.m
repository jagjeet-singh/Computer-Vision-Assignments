function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

x1 = pts1(:,1);
y1 = pts1(:,2);

x2 = pts2(:,1);
y2 = pts2(:,2);

T = [1/M, 0, 0; 0, 1/M, 0; 0, 0, 1];

x1 = x1./M;
x2 = x2./M;
y1 = y1./M;
y2 = y2./M;

one = ones(size(x1));
U = [x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, one];

[~,~,V] = svd(U);

n = size(V,2);
f0 = reshape(V(:,n-1),[3,3]);
f1 = reshape(V(:,n),[3,3]);
syms w
f_star = f0+w*f1;
DA = det(f_star);
p = sym2poly(DA);
r = roots(p);
% W = solve(DA,w);
F = f0+r(1)*f1;
% F = F./norm(F);
% [A,B,C] = svd(F);
% B(3,3) = 0;
% F = A*B*C';
F = T'*F*T;
F = refineF(F, pts1, pts2);
disp(F);
disp(numel(F));
F = {F};
% F = F./M;

end

