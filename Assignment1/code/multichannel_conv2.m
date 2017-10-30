
function y = multichannel_conv2(x,h,b)
 %     x =imrotate(x,180);
     num_filter = size(h,4);
     response = zeros(size(x,1), size(x,2), size(x,3), num_filter);
     
 
     for j=1:num_filter
         curr_filter = im2double(h(:,:,:,j));
         response(:,:,:, j) = imfilter(x, curr_filter, 'same') + b(:,:,j);
      end
     response = response(:,:,ceil(size(x,3)/2),:);
      y = reshape(response,[size(x,1),size(x,2),num_filter]); 
end










% function y = multichannel_conv2(x,h,b)
% %     x =imrotate(x,180);
%     x_pad = zeros(size(x,1)+2, size(x,2)+2, size(x,3));
%     x_pad(2:225, 2:225, :) = x;
%     num_filter = size(h,4);
%     response = zeros(size(x,1)*size(x,2), num_filter);
%     x_flat = reshape(x_pad, [size(x_pad,1)*size(x_pad,2), size(x_pad,3)]);
%     disp(size(x_flat));
%     h_flat = reshape(h, [size(h,1)*size(h,2), size(h,3), size(h,4)]);
%     b_flat = reshape(b, [size(b,1)*size(b,2), size(b,3)]);
% 
% 
%     for j=1:num_filter
%         curr_filter = im2double(h_flat(:,:,j));
% %         disp(size(sum(conv2(x_flat,curr_filter, 'same'), 2)+b_flat(j)));
%         response(:,j) = conv2(x_flat, curr_filter, 'valid') + b_flat(:,j);
% %         response(:, j) = sum(conv2(x_flat,curr_filter, 'same'), 2)+b_flat(j);
%         %response(:, j)=sum(conv2(x_flat,curr_filter, 'same'),2)+b_flat(:,j);
% %         for k=1:num_input_channels
% %             curr_filter = h(:,:,:,j);
% %             response(:,:,j) = response(:,:,j) + imfilter(x(:,:,k),curr_filter, 'replicate', 'same') ;
% %         end
% %         response(:,:,j) = response(:,:,j)+ b(:,:,j);
%     end
%     y = reshape(response, [size(x,1), size(x,2), num_filter]);
%     %y = reshape(response(:,:,ceil(size(x,3)/2),:),[size(x,1),size(x,2),num_filter]) ; 
% %     y = reshape(response,[size(x,1),size(x,2),size(response,2)]);
% end