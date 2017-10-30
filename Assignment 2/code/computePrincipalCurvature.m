function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid

PrincipalCurvature = zeros(size(DoGPyramid));

for i=1:size(DoGPyramid,3)

    [Dx, Dy] = gradient(DoGPyramid(:,:,i));
    [Dxx, Dxy] = gradient(Dx);
    [Dyx, Dyy] = gradient(Dy);
    
    for j=1:size(Dxx,1)
        for k=1:size(Dxx,2)
            
            H = [Dxx(j,k), Dxy(j,k); Dyx(j,k), Dyy(j,k)];
            PrincipalCurvature(j,k,i) = trace(H)^2/det(H);
        end
    end
end