function [ img_blend ] = poi_blend_wrapper( img1, img2, mask )
%poi_blend_wrapper blends two images using poisson blending method.
%   Detailed explanation goes here

I1 = double(img1);
I2 = double(img2);

feat1 = im_grad_feature(I1);
feat2 = im_grad_feature(I2);

mask_rep = repmat(mask, 1, 1, 3, 5);

feat_blend = feat1;
feat_blend(mask_rep) = feat2(mask_rep);

param = build_poi_param(size(mask_rep, 1), size(mask_rep, 2));
img_blend = uint8(poisson_blend(feat_blend, param));

end

