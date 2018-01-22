
k = dir('C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric\Experiment Subset\Hamilt3\*.tiff');
filenames = {k.name}';


correspondence_cube3 = {};
corr_name = 'correspondence_cube3';
Image = {};
Test = {};
clear Data;

for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
     fname=k(i).name
     Test{i}=rgb2gray(im2double(imread(fname)));
     % Test{i}=im2double(imread(fname));
    %expVal = FindExposure(fname)
    %imwrite
end

for pic=0:17
ind=(3*pic)+1;
%Phase map for Hamiltonian cycle of cube
% Image{1}=rgb2gray(im2double(imread('IMG_6484.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_6485.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_6486.tiff')));
% Image{1}=im2double(imread('Image1.tiff'));
% Image{2}=im2double(imread('Image2.tiff'));
% Image{3}=im2double(imread('Image3.tiff'));
Image{1}= Test{ind};
Image{2}= Test{ind+1};
Image{3}= Test{ind+2};
m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
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
val=zeros(size(ma));
val=((middle-v2)./(v-v2));

for i = 0:1:6
    [a]=find(label_image==i);
    if (i ==1)
         column_correspondence(a)=val(a)*(1920/6);
    end
    if(i==2)
         column_correspondence(a)=(1+1-val(a))*(1920/6);
    end
    if(i==3)
         column_correspondence(a)=(2+val(a))*(1920/6);
    end
    if(i==4)
         column_correspondence(a)=(3+1-val(a))*(1920/6);
    end
    if(i==5)
         column_correspondence(a)=(4+val(a))*(1920/6);
    end
    if(i==6)
         column_correspondence(a)=(5+1-val(a))*(1920/6);
    end
    if(i==0)
        for j=1:size(a,1)
            
                I(1)=(Image{1}(a(j)));
                I(2)=(Image{3}(a(j)));
                I(3)=(Image{2}(a(j)));
                if (I(1)==I(2))
                    value = I(1);
                    if (value > 0.1)
                        high=I(1);
                        middle = I(2);
                        small=I(3);
                        column_correspondence(a(j))=((middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        middle=I(2);
                        high=I(3);
                        column_correspondence(a(j))=(3+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                if (I(2)==I(3))
                    value = I(2);
                    if (value >0.1)
                        small=I(1);
                         middle =I(2);
                        high=I(3);
                        column_correspondence(a(j))=(4+(middle-small)/(high-small))*(1920/6);
                    else
                        high=I(1);
                        middle=I(2);
                        small=I(3);
                        column_correspondence(a(j))= (1+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                
                if (I(1)==I(3))
                    value = I(3);
                    if (value >0.1)
                        high=I(1);
                        small=I(2);
                        middle=I(3);
                        column_correspondence(a(j))= (2+(middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        high=I(2);
                        middle=I(3);
                        column_correspondence(a(j)) = (5+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
        end
    end
end
correspondence_cube3{pic+1}=column_correspondence;
[m1, n1] = size(correspondence_cube3{1});
fig = plot(1:n1, correspondence_cube3{pic+1}(2500, :));
fname1 = ['Hamilt3', sprintf('%04d', pic), '.png'];
saveas(fig,fname1);
clear M
end
save(sprintf('%s.mat',corr_name), corr_name,'-v7.3');

%%

for pic=1:30
%Phase map for Hamiltonian cycle of cube
% Image{1}=rgb2gray(im2double(imread('IMG_6484.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_6485.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_6486.tiff')));
%Image{1}= Test{ind};
%Image{2}= Test{ind+1};
%Image{3}= Test{ind+2};
Image{1}= Test{pic};
Image{2}= Test{30+pic};
Image{3}= Test{60+pic};
m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
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
val=zeros(size(ma));
val=((middle-v2)./(v-v2));

for i = 0:1:6
    [a]=find(label_image==i);
    if (i ==1)
         column_correspondence(a)=val(a)*(1920/6);
    end
    if(i==2)
         column_correspondence(a)=(1+1-val(a))*(1920/6);
    end
    if(i==3)
         column_correspondence(a)=(2+val(a))*(1920/6);
    end
    if(i==4)
         column_correspondence(a)=(3+1-val(a))*(1920/6);
    end
    if(i==5)
         column_correspondence(a)=(4+val(a))*(1920/6);
    end
    if(i==6)
         column_correspondence(a)=(5+1-val(a))*(1920/6);
    end
    if(i==0)
        for j=1:size(a,1)
            
                I(1)=(Image{1}(a(j)));
                I(2)=(Image{3}(a(j)));
                I(3)=(Image{2}(a(j)));
                if (I(1)==I(2))
                    value = I(1);
                    if (value > 0.1)
                        high=I(1);
                        middle = I(2);
                        small=I(3);
                        column_correspondence(a(j))=((middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        middle=I(2);
                        high=I(3);
                        column_correspondence(a(j))=(3+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                if (I(2)==I(3))
                    value = I(2);
                    if (value >0.1)
                        small=I(1);
                         middle =I(2);
                        high=I(3);
                        column_correspondence(a(j))=(4+(middle-small)/(high-small))*(1920/6);
                    else
                        high=I(1);
                        middle=I(2);
                        small=I(3);
                        column_correspondence(a(j))= (1+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                
                if (I(1)==I(3))
                    value = I(3);
                    if (value >0.1)
                        high=I(1);
                        small=I(2);
                        middle=I(3);
                        column_correspondence(a(j))= (2+(middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        high=I(2);
                        middle=I(3);
                        column_correspondence(a(j)) = (5+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
        end
    end
end
correspondence_cube2{pic}=column_correspondence;
end
%save('Cube.mat','correspondence_cube','-v7.3');
for pic=1:30
%Phase map for Hamiltonian cycle of cube
% Image{1}=rgb2gray(im2double(imread('IMG_6484.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_6485.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_6486.tiff')));
%Image{1}= Test{ind};
%Image{2}= Test{ind+1};
%Image{3}= Test{ind+2};
Image{1}= Test{pic+90};
Image{2}= Test{30+pic+90};
Image{3}= Test{60+pic+90};
m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
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
val=zeros(size(ma));
val=((middle-v2)./(v-v2));

for i = 0:1:6
    [a]=find(label_image==i);
    if (i ==1)
         column_correspondence(a)=val(a)*(1920/6);
    end
    if(i==2)
         column_correspondence(a)=(1+1-val(a))*(1920/6);
    end
    if(i==3)
         column_correspondence(a)=(2+val(a))*(1920/6);
    end
    if(i==4)
         column_correspondence(a)=(3+1-val(a))*(1920/6);
    end
    if(i==5)
         column_correspondence(a)=(4+val(a))*(1920/6);
    end
    if(i==6)
         column_correspondence(a)=(5+1-val(a))*(1920/6);
    end
    if(i==0)
        for j=1:size(a,1)
            
                I(1)=(Image{1}(a(j)));
                I(2)=(Image{3}(a(j)));
                I(3)=(Image{2}(a(j)));
                if (I(1)==I(2))
                    value = I(1);
                    if (value > 0.1)
                        high=I(1);
                        middle = I(2);
                        small=I(3);
                        column_correspondence(a(j))=((middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        middle=I(2);
                        high=I(3);
                        column_correspondence(a(j))=(3+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                if (I(2)==I(3))
                    value = I(2);
                    if (value >0.1)
                        small=I(1);
                         middle =I(2);
                        high=I(3);
                        column_correspondence(a(j))=(4+(middle-small)/(high-small))*(1920/6);
                    else
                        high=I(1);
                        middle=I(2);
                        small=I(3);
                        column_correspondence(a(j))= (1+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                
                if (I(1)==I(3))
                    value = I(3);
                    if (value >0.1)
                        high=I(1);
                        small=I(2);
                        middle=I(3);
                        column_correspondence(a(j))= (2+(middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        high=I(2);
                        middle=I(3);
                        column_correspondence(a(j)) = (5+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
        end
    end
end
correspondence_cube2{pic}=column_correspondence;
end   
for pic=1:30
%Phase map for Hamiltonian cycle of cube
% Image{1}=rgb2gray(im2double(imread('IMG_6484.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_6485.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_6486.tiff')));
%Image{1}= Test{ind};
%Image{2}= Test{ind+1};
%Image{3}= Test{ind+2};
Image{1}= Test{pic+180};
Image{2}= Test{30+pic+180};
Image{3}= Test{60+pic+180};
m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
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
val=zeros(size(ma));
val=((middle-v2)./(v-v2));

for i = 0:1:6
    [a]=find(label_image==i);
    if (i ==1)
         column_correspondence(a)=val(a)*(1920/6);
    end
    if(i==2)
         column_correspondence(a)=(1+1-val(a))*(1920/6);
    end
    if(i==3)
         column_correspondence(a)=(2+val(a))*(1920/6);
    end
    if(i==4)
         column_correspondence(a)=(3+1-val(a))*(1920/6);
    end
    if(i==5)
         column_correspondence(a)=(4+val(a))*(1920/6);
    end
    if(i==6)
         column_correspondence(a)=(5+1-val(a))*(1920/6);
    end
    if(i==0)
        for j=1:size(a,1)
            
                I(1)=(Image{1}(a(j)));
                I(2)=(Image{3}(a(j)));
                I(3)=(Image{2}(a(j)));
                if (I(1)==I(2))
                    value = I(1);
                    if (value > 0.1)
                        high=I(1);
                        middle = I(2);
                        small=I(3);
                        column_correspondence(a(j))=((middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        middle=I(2);
                        high=I(3);
                        column_correspondence(a(j))=(3+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                if (I(2)==I(3))
                    value = I(2);
                    if (value >0.1)
                        small=I(1);
                         middle =I(2);
                        high=I(3);
                        column_correspondence(a(j))=(4+(middle-small)/(high-small))*(1920/6);
                    else
                        high=I(1);
                        middle=I(2);
                        small=I(3);
                        column_correspondence(a(j))= (1+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                
                if (I(1)==I(3))
                    value = I(3);
                    if (value >0.1)
                        high=I(1);
                        small=I(2);
                        middle=I(3);
                        column_correspondence(a(j))= (2+(middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        high=I(2);
                        middle=I(3);
                        column_correspondence(a(j)) = (5+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
        end
    end
end
correspondence_cube3{pic}=column_correspondence;
end   
for pic=1:30
%Phase map for Hamiltonian cycle of cube
% Image{1}=rgb2gray(im2double(imread('IMG_6484.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_6485.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_6486.tiff')));
%Image{1}= Test{ind};
%Image{2}= Test{ind+1};
%Image{3}= Test{ind+2};
Image{1}= Test{pic+270};
Image{2}= Test{30+pic+270};
Image{3}= Test{60+pic+270};
m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
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
val=zeros(size(ma));
val=((middle-v2)./(v-v2));

for i = 0:1:6
    [a]=find(label_image==i);
    if (i ==1)
         column_correspondence(a)=val(a)*(1920/6);
    end
    if(i==2)
         column_correspondence(a)=(1+1-val(a))*(1920/6);
    end
    if(i==3)
         column_correspondence(a)=(2+val(a))*(1920/6);
    end
    if(i==4)
         column_correspondence(a)=(3+1-val(a))*(1920/6);
    end
    if(i==5)
         column_correspondence(a)=(4+val(a))*(1920/6);
    end
    if(i==6)
         column_correspondence(a)=(5+1-val(a))*(1920/6);
    end
    if(i==0)
        for j=1:size(a,1)
            
                I(1)=(Image{1}(a(j)));
                I(2)=(Image{3}(a(j)));
                I(3)=(Image{2}(a(j)));
                if (I(1)==I(2))
                    value = I(1);
                    if (value > 0.1)
                        high=I(1);
                        middle = I(2);
                        small=I(3);
                        column_correspondence(a(j))=((middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        middle=I(2);
                        high=I(3);
                        column_correspondence(a(j))=(3+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                if (I(2)==I(3))
                    value = I(2);
                    if (value >0.1)
                        small=I(1);
                         middle =I(2);
                        high=I(3);
                        column_correspondence(a(j))=(4+(middle-small)/(high-small))*(1920/6);
                    else
                        high=I(1);
                        middle=I(2);
                        small=I(3);
                        column_correspondence(a(j))= (1+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                
                if (I(1)==I(3))
                    value = I(3);
                    if (value >0.1)
                        high=I(1);
                        small=I(2);
                        middle=I(3);
                        column_correspondence(a(j))= (2+(middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        high=I(2);
                        middle=I(3);
                        column_correspondence(a(j)) = (5+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
        end
    end
end
correspondence_cube4{pic}=column_correspondence;
end   