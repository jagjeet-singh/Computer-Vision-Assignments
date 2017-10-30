function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC

max_inliers = 0;



for iter=1:nIter

    inliers = 0;
    sample = datasample(matches,4);

    x = locs1(sample(:,1),1);
    y = locs1(sample(:,1),2);

    u = locs2(sample(:,2),1);
    v = locs2(sample(:,2),2);

    zero = zeros(size(sample,1),1);
    one = ones(size(sample,1),1);

    A_y = [zero,zero,zero,-u,-v,-one,y.*u,y.*v,y];
    A_x = [u,v,one,zero,zero,zero,-x.*u,-x.*v,-x];

    A = A_x([1;1]*(1:size(A_x,1)),:);
    A(1:2:end,:) = A_y;

    [~,~,V] = svd(A);

    H = reshape(V(:,end),[3,3])';
    H = H/H(3,3);

    for i=1:size(matches,1)

        X_i = [locs1(matches(i,1),1);locs1(matches(i,1),2);1];

        X_pred = H*[locs2(matches(i,2),1);locs2(matches(i,2),2);1];
        X_pred = X_pred./X_pred(3,1);

        dist = sqrt((X_pred(1) - X_i(1))^2+(X_pred(2) - X_i(2))^2);
        if dist < tol
            inliers = inliers+1;
        end
    end
    if inliers > max_inliers
        max_inliers = inliers;
        bestH = H;
        disp(max_inliers);
    end



end

end
    




