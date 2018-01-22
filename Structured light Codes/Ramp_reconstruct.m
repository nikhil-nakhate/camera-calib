
k = dir('E:\Final 36 set\K=3\Ramp3_0.2*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
     fname=k(i).name
     %Test{i}=rgb2gray(im2double(imread(fname)));
     Test{i}=im2double(imread(fname));
    %expVal = FindExposure(fname)
    %imwrite
end
Zero{1}=Test{1};

for pic=0
% ind=(3*pic)+1;
ind=2*pic+1;
%Phase map for Ramp
%Image{1}=rgb2gray(im2double(imread('IMG_9760.tiff')));
%Image{2}=rgb2gray(im2double(imread('IMG_9761.tiff')));
%Image{3}=rgb2gray(im2double(imread('IMG_9762.tiff')));
% Image{1}= Test{ind};
% Image{2}= Test{ind+1};
% Image{3}= Test{ind+2};
Image{1}= Test{ind};
Image{2}= Test{ind+1};
Image{3}= Zero{1};

m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
% help(:,:,1)=Image{1};
% help(:,:,2)=Image{2};
% help(:,:,3)=Image{3};
% %n=1920;
% N = 3;
% phi = zeros(m,n);
% column_correspondence=zeros(m,n);
% M=[0 1 1;1 0 1; 0 0 1];
% M=pinv(M);
% x=reshape(help,(m*n),3);
% X=M*x';
% v=X(1,:);
% u=X(2,:);
% phi_p=(u./v).*1920;
% phi=reshape(phi_p,m,n);
% column_correspondence=phi;


help(:,:,1)=Image{1};
help(:,:,2)=Image{2};
help(:,:,3)=Image{3};
[v,ma]= max(help,[],3);
[v2,mi]= min(help,[],3);
middle=median(help,3);
med=zeros(size(ma));
med(ma+mi==3)=3;
med(ma+mi==4)=2;
med(ma+mi==5)=1;
label_image=zeros(size(ma));
label_image(med==1&ma==2&mi==3)=1;
label_image(ma==1&med==2&mi==3)=2;
label_image(ma==1&mi==2&med==3)=3;
label_image(med==1&mi==2&ma==3)=4;
label_image(mi==1&med==2&ma==3)=5;
label_image(mi==1&ma==2&med==3)=6;
column_correspondence=((middle-v2)./(v-v2));
correspondence_ramp_column{pic+1}=column_correspondence;
end
[m, n] = size(correspondence_ramp_column{1}(1, :));
fig = plot(1:n, correspondence_ramp_column{1}(1, :));
saveas(fig,'Ramp3.png')
%save('Ramp.mat','correspondence_ramp','-v7.3');
        