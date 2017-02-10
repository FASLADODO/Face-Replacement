function [ I_polar, ratio ] = convert_pol( I, center, radius )
%convert_pol converts image I into log-polar coordinate at point specified.
%   I: Input image
%   center: origin of the log-polar coordinate system.
%   radius: maximum radius needed.
%   I_polar: image in log_polar coordinate system.

ratio = radius / max(400, ceil(radius));
r = linspace(0, radius, max(400, ceil(radius)))';
phi = linspace(0, 6 * pi, 1800);
I_polar = zeros(length(r), length(phi), size(I, 3));

x = r * sin(phi) + center(1);
y = r * cos(phi) + center(2);

for i = 1: size(I, 3)
    I_polar(:, :, i) = interp2(double(I(:, :, i)), x, y);
end

I_polar(isnan(I_polar)) = max(max(max(I_polar)));

end

