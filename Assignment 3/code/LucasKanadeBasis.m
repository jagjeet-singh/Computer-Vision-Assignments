function [dp_x,dp_y] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y] in the x- and y-directions.
It = im2double(It);
It1 = im2double(It1);

x1 = round(rect(1));
y1 = round(rect(2));
x2 = round(rect(3));
y2 = round(rect(4));
width = x2 - x1;
height = y2 - y1;

bases_reshaped = reshape(bases, size(bases,1)*size(bases,2),size(bases,3));

threshold = 0.2;
p = [0.5,0.5]';
l2_delta_p = 100;
[Grad_I_x,Grad_I_y] = gradient(It1);
count = 0;

% Setting maximum number of iterations to overcome local minima
while l2_delta_p > threshold %&& count<100
    count = count+1;
    W = [1,0,p(1);0,1,p(2)];
    warped_top_left = W*[x1;y1;1];
    warped_bot_right = W*[x2;y2;1];
    warped_x1 = warped_top_left(1);
    warped_y1 = warped_top_left(2);
    warped_x2 = warped_bot_right(1);
    warped_y2 = warped_bot_right(2);
    Jacobian_W = [1,0;0,1];
    [x,y] = meshgrid(x1:x1+width,y1:y1+height);
%     size(x)
%     size(y)
    [warped_x, warped_y] = meshgrid(warped_x1:warped_x1+width, warped_y1:warped_y1+height);
    T = interp2(It,x,y);
%     warped_I = interp2(It1, round(warped_x), round(warped_y));
    warped_I = interp2(It1, warped_x, warped_y);
    Err = T-warped_I;
    Grad_x = interp2(Grad_I_x,warped_x, warped_y);
%     Grad_x = interp2(Grad_I_x,round(warped_x), round(warped_y));
    Grad_y = interp2(Grad_I_y,warped_x, warped_y);
%     Grad_y = interp2(Grad_I_y,round(warped_x), round(warped_y));
%     delta_I = [interp2(Grad_I_x,warped_x, warped_y),interp2(Grad_I_y,warped_x, warped_y)];
    steepest_desc = [Grad_x(:),Grad_y(:)]*Jacobian_W;
%     bases_reshaped_all_pixels = sum(bases_reshaped,1);
%     SDQ = zeros(size(steepest_desc));
%     for i=1:size(bases_reshaped,1)
%         second_term = zeros(1,2);
%         for j=1:size(bases_reshaped,2)
%             second_term = second_term + (bases_reshaped_all_pixels(j).*steepest_desc(i,:)).*bases_reshaped(i,j);
%         end
%         SDQ(i,:) = steepest_desc(i,:)-second_term;
%     end
    
%     SDQ = steepest_desc.*(1-sum((sum(bases_reshaped,1).*bases_reshaped),2));
    total = zeros(size(steepest_desc));
    for i = 1:10
        total = total + sum((bases_reshaped(:,i).*steepest_desc),1).*bases_reshaped(:,i);
    end
    SDQ = steepest_desc-total;
    H = SDQ'*SDQ;
    b = SDQ'*Err(:);
%     
%     H = steepest_desc'*steepest_desc;
%     b = steepest_desc'*Err(:);

    delta_p = H\b;
    l2_delta_p = sum(delta_p.^2);
    p = p+delta_p;
    dp_x = p(1);
    dp_y = p(2);
%     disp(norm(delta_p));
end
end
