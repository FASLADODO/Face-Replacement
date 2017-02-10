function [part,part_filter,relative_mean_x,relative_mean_y,relative_var_x,relative_var_y,clicks_x,clicks_y] = train_parts(img_array,num_click,num_im,width,height)

x = zeros(1, num_click);
y = zeros(1, num_click);
part = cell(1, num_click);%hand selected parts
part_filter = zeros(width * height, num_click);%averaged filter used for match in part_filtering step
relative_x = zeros(num_click, num_im);%relative x distance between feature and reference point
relative_y = zeros(num_click, num_im);%relative y distance between feature and reference point
clicks_x = zeros(num_click , num_im);%hand click features x coordinates
clicks_y = zeros(num_click , num_im);%hand click features y coordinates
 
for i=1:num_im
    filename = [sprintf('%03d', img_array(i)) '.jpg'];
    fullname = fullfile('easy_4/train_4', filename);
    im=imread(fullname);
    im_gray = rgb2gray(im);
    figure(100);clf;
    imshow(im);
    hold on;
    %click features
    for click = 1: num_click
        [x(click), y(click)] = ginput(1);
        plot(x(click), y(click), 'r.');
        rect = [x(click) - width / 2, y(click) - height / 2, width - 1, height-1];
        rectangle('Position', rect, 'EdgeColor', 'r');
    end
    %get parts
    for j=1: num_click
        rect = [x(j) - width / 2, y(j) - height / 2, width - 1, height - 1];
        p = imcrop(im_gray, rect);
        part{j}(:, i) = p(:);
    end
    %calculate relative distance
    relative_x(:, i) = (x - x(1))';
    relative_y(:, i) = (y - y(1))';
    clicks_x(:, i) = x';
    clicks_y(:, i) = y';    
end

%get average filter from parts[
for k=1: num_click
  part_filter(:, k) = mean(part{k}, 2);
end

%calculate mean and variance of relative distance
relative_mean_x = mean(relative_x, 2);
relative_mean_y = mean(relative_y, 2);
relative_var_x  = var(relative_x, 0, 2);
relative_var_y  = var(relative_y, 0, 2);

end