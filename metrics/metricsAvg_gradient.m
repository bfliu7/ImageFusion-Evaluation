



function res = metricsAvg_gradient(img1,img2,fused)
    if nargin == 3 
        img1 = img1;
        img2 = img2;
        fused = double(fused); 
        [r,c,b] = size(fused); 

        dx = 1; 
        dy = 1; 
        for k = 1 : b 
            band = fused(:,:,k); 
            [dzdx,dzdy] = gradient(band,dx,dy); 
            s = sqrt((dzdx .^ 2 + dzdy .^2) ./ 2); 
            g(k) = sum(sum(s)) / ((r - 1) * (c - 1)); 
        end 
        res = mean(g); 
    else 
        error('Wrong number of input!'); 
    end
end