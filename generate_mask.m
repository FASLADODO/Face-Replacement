function [ mask ] = generate_mask( I, center, radius )
%Generate_mask creates a mask of face on the given image based on the given
% center of the face and radius.
%   (INPUT)  I: H×W×3 matrix of color image or H×W matrix grayscale 
%               image.
%            center: 1×2 matrix representing the center coordinate of the
%               image.
%            radius: double radius of the face
%   (OUTPUT) mask: H×W binary matrix of mask.

[img_height, img_width, ~] = size(I);

[I_polar, ratio] = convert_pol(I, center, radius);
E_polar = genEngMap(uint8(I_polar));

[My, Tby] = cumMinEngHor(E_polar);
[rmIdx] = rmHorSeam(uint8(I_polar), My, Tby);
rmRadius = rmIdx * ratio;

phi = linspace(0, 2 * pi, 600);
x = rmRadius(601: 1200) .* sin(phi) + center(1);
y = rmRadius(601: 1200) .* cos(phi) + center(2);

x = [x, x(1)];
y = [y, y(1)];

mask = poly2mask(x, y, img_height, img_width);

end

