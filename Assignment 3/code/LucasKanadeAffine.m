function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix

It = im2double(It);    % Warping It1 to outsize of It with fill value as -1

It1 = im2double(It1);
p = [0,0,0,0,0,0]';

delta_p = 10*ones(size(p));

threshold = 1;
outsize = size(It);


while norm(delta_p) > threshold
    
    % Warp function for affine
    W = [1+p(1),p(3),p(5);p(2),1+p(4),p(6);0,0,1];
    
    warp_It = warpH(It, W, outsize);

   
    [Grad_x, Grad_y] = gradient(warp_It);

   
%     Jacobian_W = zeros(outsize,2,6);
    steepest_desc = zeros(outsize(1),outsize(2),6);
    for i = 1:outsize(1)
        for j=1:outsize(2)
            J = [j,0,i,0,1,0;0,j,0,i,0,1];
            steepest_desc(i,j,:) = [Grad_x(i,j),Grad_y(i,j)]*J;
        end
    end
    
    steepest_desc = reshape(steepest_desc, outsize(1)*outsize(2),6);
   Err = warp_It-It1;
  H = steepest_desc'*steepest_desc;
    Total_desc_Err = steepest_desc'*Err(:);

    delta_p = H\Total_desc_Err;
    p = p+delta_p;
    disp(norm(delta_p));
end

M = W;
end
