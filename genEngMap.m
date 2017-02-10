function e = genEngMap(I)
% I is an image. I could be of color or grayscale.
% e is the energy map of n-by-m matrix.

if ndims(I) == 3
    % Assume the image fed in is a 3-channel RGB color image
    Ig = double(rgb2gray(I)); 
else
    % Assume the image fed in is a grayscale image
    Ig = double(I);
end

[ny, nx] = size(Ig);
[~, R] = meshgrid(1: nx, 1: ny);

[~, gy] = gradient(Ig);
gy = abs(gy);
s = 1 - gy / max(max(gy));

d = (R - ny*0.6).^2;

intensity = Ig(:);
intensity(intensity == 255) = [];
GMM = fitgmdist(intensity, 2, 'CovarianceType', 'diagonal',...
    'Options', statset('MaxIter', 1500));
mu_bg = GMM.mu(1);
mu_face = GMM.mu(2);

alpha = 0.3;
G = alpha * mu_face + (1 - alpha) * mu_bg;
g = sqrt(abs(Ig - G));

wd = 0.5/max(d(:, 1));
wg = 1/max(max(g));
e = s + wd * d + wg * g;

end