function [landmarks] = replace_face_feature(img,num_click)

figure;
imshow(img);
hold on

x_img = zeros(num_click, 1);
y_img = zeros(num_click, 1);

for i=1: num_click
    [x_img(i), y_img(i)] = ginput(1);
    plot(x_img(i), y_img(i), 'r.');
end

landmarks = [x_img, y_img];

end