function part_filtering(part_filter,num_im,num_parts,filter_size)

for i=1:num_im
    filename = [sprintf('%03d',i) '.jpg'];
    fullname = fullfile('easy_4/test_4',filename);
    ip_file_name = [sprintf('%03d',i) '.mat'];
    full_ip_name = fullfile('easy_4/interest_point4',ip_file_name);
    im=imread(fullname);
    im=rgb2gray(im);
    [W,H]=size(im);
    response_image=zeros(W,H,num_parts);%result of matching part filter and image
    for j=1:num_parts
        % do normalized cross correlation
        tmp_image = normxcorr2(reshape(part_filter(:,j),[filter_size filter_size]),im);%matching
        offset = round(filter_size/2);
        %get cost map
        response_image(:,:,j) = tmp_image(filter_size-offset:end-offset,filter_size-offset:end-offset);
        save(full_ip_name,'response_image');
    end
end
end