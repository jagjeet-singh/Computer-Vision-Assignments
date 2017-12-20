function bestM2 = findBestM2(M2s, K1, K2, M1, p1, p2)

bestM2 = M2s(:,:,1);
for j = 1:size(M2s,3)
    M2 = M2s(:,:,j);
    C1 = K1*M1;
    C2 = K2*M2;
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
    if isempty(find(P(:,3)<0))
         bestM2 = M2;
         disp(j);
         disp(P);
    end
    
end
end