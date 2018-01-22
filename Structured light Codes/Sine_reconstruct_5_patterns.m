k = dir('C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric\Experiment Subset\Sine5\IMG_*.tiff');
filenames = {k.name}';

% indices = 9370:9549;
correspondence_sine5_row = {};
corr_name = 'correspondence_sine5_row';
Image = {};
Test = {};
clear Data;

indices = [5172: 5201 5250:5279 5328:5357];
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
Image{5}= Test{ind+4};

% Image{1}=rgb2gray(im2double(imread('IMG_2051.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_2052.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_2053.tiff')));
% Image{4}=rgb2gray(im2double(imread('IMG_2054.tiff')));
% Image{5}=rgb2gray(im2double(imread('IMG_2055.tiff')));
% Image{1}=im2double(imread('Image1.tiff'));
% Image{2}=im2double(imread('Image2.tiff'));
% Image{3}=im2double(imread('Image3.tiff'));
% Image{4}=im2double(imread('Image4.tiff'));
% Image{5}=im2double(imread('Image5.tiff'));
m=size(Image{1},1);
n=size(Image{1},2);
N = 5;
help(:,:,1)=Image{1};
help(:,:,2)=Image{2};
help(:,:,3)=Image{3};
help(:,:,4)=Image{4};
help(:,:,5)=Image{5};
for i = 1:N
            M(i,:) = [1 cos(2*pi*(i-1)/N) -sin(2*pi*(i-1)/N)];
end
M=pinv(M);
x=reshape(help,(m*n),5);
X=M*x';
v=X(3,:);
b=find(v>=0);
a=find(v<0);
X(3,b)=acos(X(2,b)./sqrt(X(2,b).^2 + X(3,b).^2));
X(3,a)=2*pi-acos(X(2,a)./sqrt(X(2,a).^2 + X(3,a).^2));
phi_p=X(3,:);
phi=reshape(phi_p,m,n);
correspondence_sine5_row{pic+1}=phi;
correspondence_sine5_row{pic+1}=correspondence_sine5_row{pic+1}*1920/(2*pi);
[m1, n1] = size(correspondence_sine5_row{pic+1}(2500, :));
fig = plot(1:n1, correspondence_sine5_row{pic+1}(2500, :));
fname1 = ['Sine5', sprintf('%04d', pic), '.png'];
saveas(fig,fname1);
clear M
end
save(sprintf('%s.mat',corr_name), corr_name,'-v7.3');