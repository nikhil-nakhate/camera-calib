% SET ALL THIS AND ALSO CHECK IF RGB OR NOT
% dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric\Hamilt5GT\';

% NOT REQUIRED
% indices = [5124:5141 5202:5219 5280:5297];
% indices = 1:5;

% SET THIS
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric\Publishable\Captured\Ham4\';
% refactor using shift + enter
corrHamilt4 = {};

corr_name = 'corrHamilt4';

% set k, the rest is handled
k = 4;

% This is 1 for GT
total_cond = 36;

f_in_dir = dir([ dirname, '*.tiff']);
filenames = {f_in_dir.name}';

Image = {};
Test = {};
clear Data;
Data = [];
clear help ind pic;

%img_prefix = 'HAMILT3_GT';
img_prefix = 'IMG_';
%%
for i=1:numel(filenames)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
    %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    %fname = [dirname, 'IMG_', sprintf('%04d', indices(i)), '.tiff']
    % fname = [dirname, img_prefix, sprintf('%d', indices(i)), '.tiff']
    fname = filenames{i}
    %fname=k(i).name
    Test{i}=rgb2gray(im2double(imread(fname)));
    % Test{i}=im2double(imread(fname));
end

for pic=0:total_cond - 1
% ind=(5*pic)+1
% ind=(4*pic)+1
ind = (k*pic) + 1

for i = 1:k
    Image{i}= Test{ind + i -1};
    Data = [Data, Image{i}(:)];
end

m=size(Image{1},1);
n=size(Image{1},2);


% Data = [Image{1}(:), Image{2}(:), Image{3}(:)];
% Data = [Image{1}(:), Image{2}(:), Image{3}(:), Image{4}(:)];
% Data = [Image{1}(:), Image{2}(:), Image{3}(:), Image{4}(:), Image{5}(:)];
Data = Data.';

%[IntervalIndices{pic+1}, Depths{pic+1}] = DecodeHilbertDimTwoThree(Data, 1920, 2, 1, 0.25);
[IntervalIndices{pic+1}, corrHamilt4{pic+1}] = DecodeHilbertDimOne(Data, 1920);

corrHamilt4{pic+1} = reshape(corrHamilt4{pic+1},[m,n]);
[m1, n1] = size(corrHamilt4{pic+1}(2500, :));
fig = plot(1:n1, corrHamilt4{pic+1}(2500, :));

fname1 = [corr_name, sprintf('%02d', pic), '.png'];
saveas(fig,fname1);
clear Data;
Data = [];
end
corr_path = [dirname, sprintf('%s.mat', corr_name)];
save(corr_path, corr_name , '-v7.3');