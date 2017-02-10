function [rmIdx] = rmHorSeam(I, My, Tby)
% I is the image. Note that I could be color or grayscale image.
% My is the cumulative minimum energy map along horizontal direction.
% Tby is the backtrack table along horizontal direction.
% Iy is the image removed one row.
% E is the cost of seam removal

[~, ny, ~] = size(I);
rmIdx = zeros(1, ny);
% Iy = uint8(zeros(nx-1, ny, nz));

%% Add your code here
[~, rmIdx(end)] = min(My(:, end));
for i = ny - 1: -1: 1
    rmIdx(i) = rmIdx(i + 1) + Tby(rmIdx(i + 1), i + 1);
end
% rmInd = sub2ind([nx, ny, nz], repmat(rmIdx, 1, nz), repmat(1: ny, 1, nz), reshape(repmat(1: nz, ny, 1), [1, ny*nz]));
% I_trans = permute(I, [2 1 3]);
% I_vec = I(:);
% I_vec(rmInd) = [];
% Iy = reshape(I_vec, [nx-1, ny, nz]);
% figure;
% imshow(I);
% hold on;
% plot(1: ny, rmIdx, 'r-');
end
