function landmarks2 = test_dis_transform(num_im,num_parts,relative_mean_x,relative_mean_y,relative_var_x,relative_var_y)

weight=5;

%%% round means to integer values
relative_mean_x = round(relative_mean_x);
relative_mean_y = round(relative_mean_y);

%%% get absolute values of means
abs_mean_x = abs(relative_mean_x);
abs_mean_y = abs(relative_mean_y);

for i = 1:num_im
    ip_file_name = [sprintf('%03d',i) '.mat'];
    full_ip_name = fullfile('easy_4/interest_point4',ip_file_name);
    load(full_ip_name); 
    
    [imy, imx, ~] = size(response_image);
    
    overall_resp = zeros(imy, imx);
    part_resp = zeros(imy, imx, num_parts - 1);
    locations = cell(1, num_parts - 1);
  
    for p=2:num_parts
        padded_response_image = padarray(-weight * response_image(:, :, p),...
            [abs_mean_y(p), abs_mean_x(p)], 1e200, 'both');                      
        translated_response =...
            padded_response_image(((abs_mean_y(p) + relative_mean_y(p) + 1): (imy + (abs_mean_y(p) + relative_mean_y(p)))),...
            ((abs_mean_x(p) + relative_mean_x(p) + 1): (imx + (abs_mean_x(p) + relative_mean_x(p)))));
        [part_resp(:, :, p-1), locations{p-1}] = dist_transform(translated_response, relative_var_x(p), relative_var_y(p));
    end
    
    overall_resp = (-weight * response_image(:,:,1)) + sum(part_resp,3);
    [~,landmark_pos] = min(overall_resp(:));
    [landmark_y, landmark_x] = ind2sub([imy imx],landmark_pos);
    
    for p = 2:num_parts
        part_x(p-1) = locations{p-1}(landmark_y,landmark_x,1);
        part_y(p-1) = locations{p-1}(landmark_y,landmark_x,2);
    end
    
    best_x = [landmark_x,part_x+relative_mean_x(2:end)'];
    best_y = [landmark_y,part_y+relative_mean_y(2:end)'];
    landmarks2(:,:,i)=[best_x',best_y'];
    
end

end