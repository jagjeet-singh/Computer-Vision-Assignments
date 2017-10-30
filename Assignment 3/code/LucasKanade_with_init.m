function [dp_x,dp_y] = LucasKanade_with_init(It, It1, rect, p_init)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y] in the x- and y-directions.
It = im2double(It);
It1 = im2double(It1);

x1 = rect(1);
y1 = rect(2);
x2 = rect(3);
y2 = rect(4);

threshold = 0.1;
p = [0,0]';
l2_delta_p = 100;
[Grad_I_x,Grad_I_y] = gradient(It1);
while l2_delta_p > threshold

    W = [1,0,p(1);0,1,p(2)];
    warped_top_left = W*[x1;y1;1];
    warped_bot_right = W*[x2;y2;1];
    warped_x1 = warped_top_left(1);
    warped_y1 = warped_top_left(2);
    warped_x2 = warped_bot_right(1);
    warped_y2 = warped_bot_right(2);
    Jacobian_W = [1,0;0,1];
    [x,y] = meshgrid(x1:x2,y1:y2);
    [warped_x, warped_y] = meshgrid(warped_x1:warped_x2, warped_y1:warped_y2);
    T = interp2(It,x,y);
    warped_I = interp2(It1, warped_x, warped_y);
    Err = T-warped_I;
    Grad_x = interp2(Grad_I_x,warped_x, warped_y);
    Grad_y = interp2(Grad_I_y,warped_x, warped_y);
%     delta_I = [interp2(Grad_I_x,warped_x, warped_y),interp2(Grad_I_y,warped_x, warped_y)];
    steepest_desc = [Grad_x(:),Grad_y(:)]*Jacobian_W;
    H = steepest_desc'*steepest_desc;
    Total_desc_Err = steepest_desc'*Err(:);

    delta_p = H\Total_desc_Err;
    l2_delta_p = sum(delta_p.^2);
    p = p+delta_p;
    dp_x = p(1);
    dp_y = p(2);
end
end
