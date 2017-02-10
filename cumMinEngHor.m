function [My, Tby] = cumMinEngHor(e)
% e is the energy map.
% My is the cumulative minimum energy map along horizontal direction.
% Tby is the backtrack table along horizontal direction.

[nx,ny] = size(e);
My = zeros(nx, ny);
Tby = zeros(nx, ny);
My(:,1) = e(:,1);

%% Add your code here

My(:, 1) = e(:, 1);
for i = 2: ny
    min_sum = ordfilt2(My(:, i-1), 1, true(3, 1), 'symmetric');
    My(:, i) = e(:, i) + min_sum;
    for j = 1: length(min_sum)
        Tby(j, i) = find(My(max(j-1, 1):min(j+1, length(min_sum)), i-1) == min_sum(j), 1, 'first') - 1 - min(j-1, 1);
    end
end
end