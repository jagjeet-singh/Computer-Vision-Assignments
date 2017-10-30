function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation

x = p1(1,:);
y = p1(2,:);

u = p2(1,:);
v = p2(2,:);

zero = zeros(size(p1,2),1);
one = ones(size(p1,2),1);

A_y = [zero,zero,zero,-u',-v',-one,y'.*u',y'.*v',y'];
A_x = [u',v',one,zero,zero,zero,-x'.*u',-x'.*v',-x'];

A = A_x([1;1]*(1:size(A_x,1)),:);
A(1:2:end,:) = A_y;

[~,~,V] = svd(A);

H2to1 = reshape(V(:,end),[3,3])';
H2to1 = H2to1/H2to1(3,3);

