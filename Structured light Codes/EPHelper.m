indices = 4401:4544;
%indices = 1:4;
for i=1:numel(indices)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
    %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    %fname=k(i).name
    Test{i}=rgb2gray(im2double(imread(fname)));
    %Test{i}=im2double(imread(fname));
    %expVal = FindExposure(fname)
    %imwrite
end

for pic=0:35
ind=(5*pic)+1
%1, 6, 11
% Image{1}= Test{pic};
% Image{2}= Test{30+pic};
% Image{3}= Test{60+pic};
% Image{4}= Test{60+pic};
% Image{5}= Test{60+pic};
%Image{1}= Test{1};
%Image{2}= Test{2};
%Image{3}= Test{3};
%Image{4}= Test{4};
%Image{5}= Test{5};

Image{1}= Test{ind};
Image{2}= Test{ind+1};
Image{3}= Test{ind+2};
Image{4}= Test{ind+3};
%Image{5}= Test{ind+4};
m=size(Image{1},1);
n=size(Image{1},2);
%Data = [Image{1}(:), Image{2}(:), Image{3}(:), Image{4}(:), Image{5}(:)];
Data = [Image{1}(:), Image{2}(:), Image{3}(:), Image{4}(:)];

Data = Data.';
%[Depths{pic+1}] = Decode_EP_5(Data);
[Depths{pic+1}] = Decode_EP_4(Data);
Depths{pic+1} = reshape(Depths{pic+1},[m,n]);
[m1, n1] = size(Depths{pic+1}(1700, :));
fig = plot(1:n1, Depths{pic+1}(1700, :));
%fname1 = ['EP5', sprintf('%04d', pic), '.png'];
fname1 = ['EP4', sprintf('%04d', pic), '.png'];
saveas(fig,fname1);
end
%save('Depths_EP5.mat','Depths','-v7.3');
save('Depths_EP4.mat','Depths','-v7.3');