k = dir('C:\Users\user\Desktop\Avg2\IMG_*.tiff');
filenames = {k.name}';

%clear all;clc
indices = 5577:5606;
%Test = {};
for i=1:numel(indices)
    %fname = ['IMG_', sprintf('%04d', indices(i)), '.CR2']
    fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    %fname=k(i).name
    Test{i}=rgb2gray(im2double(imread(fname)));
    %Test{i}=im2double(imread(fname));
    %Test{i}=imread(fname);
    %expVal = FindExposure(fname)
    %imwrite
end

Sum = Test{1};
for i=2:numel(indices)
    Sum = Sum + Test{i};
end

Average1 = Sum ./ numel(indices);
imwrite(Average1, 'HamiltGT5_5.tiff');