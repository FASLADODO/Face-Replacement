addpath '../Proj4_Test/easy'
v = VideoReader('easy4.mp4');
i=0;
while hasFrame(v)
    video = readFrame(v);
    i=i+1;
    if i==1
        filename = [sprintf('%03d',1) '.jpg'];
        fullname = fullfile('easy_4/train_4',filename);
        imwrite(video,fullname);
    end
    
    if mod(i,15)==0
        filename = [sprintf('%03d',floor(i/15+1)) '.jpg'];
        fullname = fullfile('easy_4/train_4',filename);
        imwrite(video,fullname);
    end
end
