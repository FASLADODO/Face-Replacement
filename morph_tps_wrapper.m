function [ morphed_im ] = morph_tps_wrapper( im1, im2, im1_pts, im2_pts)
%morph_tps_wrapper This is a wrapper for your TPS morphing, in which
% est_tps and morph_tps functions will be called. This function is meant to
% provide a similar interface as that in triangular morphing. It will be
% called by our evaluation script.
% (INPUT) im1: H1×W1×3 matrix representing the first image.
% (INPUT) im2: H2×W2×3 matrix representing the second image.
% (INPUT) im1_pts: N×2 matrix representing correspondences in the first
% image.
% (INPUT) im2_pts: N×2 matrix representing correspondences in the second
% image.
% (INPUT) warp_frac: parameter to control shape warping.
% (INPUT) dissolve_frac: parameter to control cross-dissolve.
% (OUTPUT) morphed_im: H2×W2×3 matrix representing the morphed image.

[h2, w2, ~] = size(im2);

%% Calculate control points in the morphed image
morphed_pts = im2_pts;
morphed_sz = [h2 w2];

%% Estimate tps parameters for image 1 and 2 in x, y
[a1_x1, ax_x1, ay_x1, w_x1] = est_tps(morphed_pts, im1_pts(:,1));
[a1_y1, ax_y1, ay_y1, w_y1] = est_tps(morphed_pts, im1_pts(:,2));

%% Generate morphed image 1, 2 and dissolve into morphed image
morphed_im = morph_tps(im1, a1_x1, ax_x1, ay_x1, w_x1,...
    a1_y1, ax_y1, ay_y1, w_y1, morphed_pts, morphed_sz);

end
