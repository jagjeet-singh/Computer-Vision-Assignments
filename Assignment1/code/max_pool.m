function p = max_pool(x,sz)
    
    p = zeros(size(x,1)-1,size(x,2)-1,size(x,3));
    step_h = sz(1);
    step_w = sz(2);
    for k=1:size(x,3)
        for i=1:size(x,1)-1
            for j=1:size(x,2)-1
                pool = x(i:i+step_h-1, j:j+step_w-1,k);
           
                p(i,j,k) = max(pool(:));
                
            end
        end
    end

end