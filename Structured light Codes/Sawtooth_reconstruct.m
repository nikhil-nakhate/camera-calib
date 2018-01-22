
k = dir('E:\Saw 16set\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
     fname=k(i).name;
     %Test{i}=rgb2gray(im2double(imread(fname)));
     Test{i}=im2double(imread(fname));
    %expVal = FindExposure(fname)
    %imwrite
end

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
%n=1920;
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
help(:,:,1)=Image{1};
help(:,:,2)=Image{2};
help(:,:,3)=Image{3};
[v,ma]= max(help,[],3);
[v2,mi]= min(help,[],3);
med=zeros(size(ma));
med(ma+mi==3)=3;
med(ma+mi==4)=2;
med(ma+mi==5)=1;
label_image=zeros(size(ma));
label_image(mi==1&ma==3&med==2)=1;
label_image(med==1&mi==3&ma==2)=2;
label_image(ma==1&med==3&mi==2)=3;
for i=1:3
    [a]=find(label_image==i);
    if(i==1)
        column_correspondence(a)=((Image{1}(a)*2*pi)./((Image{3}(a)-Image{1}(a))./0.6667));
    end
    if(i==2)
        column_correspondence(a)=((Image{1}(a)*2*pi)./((Image{3}(a)-Image{1}(a))./-0.3333));
    end
    if(i==3)
        column_correspondence(a)=((Image{1}(a)*2*pi)./((Image{2}(a)-Image{1}(a))./-0.6667));
    end
end
correspondence_saw{pic+1}=column_correspondence;
end
save('Sawtooth.mat','correspondence_saw','-v7.3');