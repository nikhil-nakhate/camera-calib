k = dir('E:\Inverse 16 set\Inverse1\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
     fname=k(i).name;
     Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

%Image1= 1; Image2 = Increasing Ramp; Image3 = Decreasing Ramp;

for pic=0:15
ind=(3*pic)+1;
%Sawtooth phase map
%Image{1}=rgb2gray(im2double(imread('IMG_0043.tiff')));
%Image{2}=rgb2gray(im2double(imread('IMG_0044.tiff')));
%Image{3}=rgb2gray(im2double(imread('IMG_0045.tiff')));
Image{1}= Test{ind};
Image{2}= Test{ind+1};
Image{3}= Test{ind+2};
m=size(Image{1},1);
n=size(Image{1},2);

help(:,:,1)=Image{1};
help(:,:,2)=Image{2};
help(:,:,3)=Image{3};
%n=1920;
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
M=[1 0 1;0 1 1; 1 -1 1];
M=pinv(M);
x=reshape(help,(m*n),3);
X=M*x';
v=X(1,:);
u=X(2,:);
phi_p=(u./v).*1920;
phi=reshape(phi_p,m,n);
column_correspondence=phi;
% val= ((Image{1}-Image{3})./((2*Image{2})-Image{1}-Image{3}));
% 
% column_correspondence = ((4*pi*val)./((3*val)-1));
correspondence_inverse1{pic+1}=column_correspondence;
end
