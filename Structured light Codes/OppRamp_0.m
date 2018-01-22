k = dir('E:\Inverse 16 set\Inverse0\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
     fname=k(i).name;
     Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

%Image1= Increasing Ramp; Image2 = Decreasing Ramp; Image3 = 0;

for pic=1:16
% ind=(3*pic)+1;
ind = 2*pic;
%Sawtooth phase map
%Image{1}=rgb2gray(im2double(imread('IMG_0043.tiff')));
%Image{2}=rgb2gray(im2double(imread('IMG_0044.tiff')));
%Image{3}=rgb2gray(im2double(imread('IMG_0045.tiff')));+
% Image{1}= Test{ind};
% Image{2}= Test{ind+1};
% Image{3}= Test{ind+2};
Image{1}= Test{ind-1};
Image{2}= Test{ind};
Image{3}= Zero{pic};
m=size(Image{1},1);
n=size(Image{1},2);

help(:,:,1)=Image{1};
help(:,:,2)=Image{2};
help(:,:,3)=Image{3};
%n=1920;
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
M=[0 1 1;1 -1 1; 0 0 1];
M=pinv(M);
x=reshape(help,(m*n),3);
X=M*x';
v=X(1,:);
u=X(2,:);
phi_p=(u./v).*1920;
phi=reshape(phi_p,m,n);
column_correspondence=phi;

% column_correspondence = 2*pi*(Image{1}-Image{3})./(Image{1}+Image{2}-(2*Image{3}));
correspondence_inverse0{pic}=column_correspondence;
end
