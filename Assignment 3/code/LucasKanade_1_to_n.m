function [dp_x,dp_y] = LucasKanade_1_to_n(It1, Itn, p_init, rect1, rectn)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y] in the x- and y-directions.
It1 = im2double(It1);
Itn = im2double(Itn);

x1 = rect1(1);
y1 = rect1(2);
x2 = rect1(3);
y2 = rect1(4);

threshold = 1;
p = [0,0]';
l2_delta_p = 100;
[Grad_I_x,Grad_I_y] = gradient(Itn);
while l2_delta_p > threshold

    W = [1,0,p(1);0,1,p(2)];
    x1_n = rectn(1)+p(1);
    y1_n = rectn(2)+p(2);
    x2_n = rectn(3)+p(1);
    y2_n = rectn(4)+p(2);
    Jacobian_W = [1,0;0,1];
    [x,y] = meshgrid(x1:x2,y1:y2);
    [xn,yn] = meshgrid(x1_n:x2_n,y1_n:y2_n);
    T = interp2(It1,x,y, 'nearest');
    Template_in_In = interp2(Itn, xn, yn, 'nearest');
    Err = T-Template_in_In;
    Grad_x = interp2(Grad_I_x,xn, yn, 'nearest');
    Grad_y = interp2(Grad_I_y,xn, yn, 'nearest');
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
