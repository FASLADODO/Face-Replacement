function [ grad_feat ] = im_grad_feature( I )
%im_grad_feature transforms am image to a feature representation which
%consists of intensity, forward horizontal diference, forward vertical
%diference, backward horizontal diference, and backward vertical diference.
%   (INPUT)     X: input image
%   (OUTPUT)	Y: feature matrix
%               Y(:,:,:,1): intensity
%               Y(:,:,:,2): forward horizontal difference
%               Y(:,:,:,3): forward vertical difference
%               Y(:,:,:,4): backward horizontal difference
%               Y(:,:,:,5): backward vertical difference

grad_feat = zeros(size(I, 1), size(I, 2), size(I, 3), 5);

Kh = [0 -1 1];
Kv = [0 -1 1]';

grad_feat(:, :, :, 1) = I;
grad_feat(:, :, :, 2) = imfilter(I, Kh, 'replicate');
grad_feat(:, :, :, 3) = imfilter(I, Kv, 'replicate');
grad_feat(:, :, :, 4) = circshift(grad_feat(:, :, :, 2), [0, 1]);
grad_feat(:, :, :, 5) = circshift(grad_feat(:, :, :, 3), [1, 0]);

end

