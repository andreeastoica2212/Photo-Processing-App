function [Wimg3] = compresie (Wimg)

[U,S,V]= svd(Wimg);

sigmas = diag(S); 

ns = length(sigmas);

approx_sigma = sigmas;
approx_sigma(20:1)=0;
approx_S = S;
approx_S(1:ns,1:ns) = diag(approx_sigma);
Wimg3 = U*approx_S*V';


end