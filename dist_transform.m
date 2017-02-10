function [out, location] = dist_transform(cost_function, x_multiply, y_multiply)

[size_y, size_x, ~]=size(cost_function);

out = zeros(size_y,size_x);
location = zeros(size_y,size_x,2);

for row=1:size_y
    [out(row,:),location(row,:,1)] = dist_transform_1d(cost_function(row,:)*x_multiply,size_x);
end

for col=1:size_x
    [out(:,col),location(:,col,2)] = dist_transform_1d(out(:,col)/x_multiply*y_multiply,size_y);
end

out = out / y_multiply;

end
