function [ param ] = build_poi_param( s1, s2 )
%build_poi_param provides a parameters which is used in ModPoisson.
%   (INPUT)     s: [s1, s2] size of output image
%   (OUTPUT)    param: the paramters to be used in poisson blending

K = zeros(s1 * 2, s2 * 2);
K(1, 1) = 4;
K(1, 2) = -1;
K(2, 1) = -1;
K(s1 * 2, 1) = -1;
K(1, s2 * 2) = -1;
param = fft2(K);
param = real(param(1: s1, 1: s2));

end

