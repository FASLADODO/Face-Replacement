clear
clc
close all

if ~exist('easy_4/result_4', 'dir')
    mkdir easy_4/result_4
end
if ~exist('easy_4/test_4', 'dir')
    mkdir easy_4/test_4
end
if ~exist('easy_4/interest_point4', 'dir')
    mkdir easy_4/interest_point4
end

width = 70;%filter width
height = width;%filter height
num_im_train = 12;%train image number
num_click = 4;%part number

 %% hand click replacement face features
img1 = 'CP.jpg';
[landmarks1] = replace_face_feature(img1,num_click);
close all
% load landmarks_cp.mat;
img1 = imread(img1);

mask_ori = generate_mask(img1, [704.05867875, 1161.78667431], 1233.02513483471);

%% train on selected target images
img_array=1:num_im_train;
[part, part_filter, relative_mean_x, relative_mean_y,...
    relative_var_x, relative_var_y, clicks_x,clicks_y] =...
    train_parts(img_array, num_click, num_im_train, width,height);
close all
% load 'easy_4/train_parts_4.mat';

%% part filtering on all target images
v = VideoReader('easy4.mp4');
i=0;
while hasFrame(v)
    video = readFrame(v);
    i=i+1;
    filename = [sprintf('%03d',i) '.jpg'];
    fullname = fullfile('easy_4/test_4',filename);
    imwrite(video,fullname);
end
num_im = i;%target images number
part_filtering(part_filter, num_im, num_click, width);

%% test part structure
landmarks2 = test_dis_transform(num_im, num_click,...
    relative_mean_x, relative_mean_y, relative_var_x, relative_var_y);

%% warping + blending
[~,~,num]=size(landmarks2);
for i=1: num
    filename = [sprintf('%03d',i) '.jpg'];
    fullname = fullfile('easy_4/test_4', filename);
    img2 = imread(fullname);
    [W, H, ~] = size(img2);
    replace_face = morph_tps_wrapper(img1, img2, landmarks1, landmarks2(:,:,i));
    mask = morph_tps_wrapper(mask_ori, img2(:, :, 1), landmarks1, landmarks2(:,:,i));
    resultImg = poi_blend_wrapper(img2, replace_face, mask);
    figure(1); imshow(resultImg);
    filename = [sprintf('%03d',i) '.jpg'];
    fullname = fullfile('easy_4/result_4',filename);
    imwrite(resultImg, fullname);
end

%% output
imageNames = dir(fullfile('easy_4/result_4','*.jpg'));
imageNames = {imageNames.name}';
outputVideo = VideoWriter('easy_4/easy4.avi');
outputVideo.FrameRate = 30;
open(outputVideo)
for ii = 1:length(imageNames)
   img = imread(fullfile('easy_4/result_4',imageNames{ii}));
   writeVideo(outputVideo,img)
end
close(outputVideo)
