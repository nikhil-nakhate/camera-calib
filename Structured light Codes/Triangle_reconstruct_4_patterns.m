%dirname         = ['C:\Users\user\Desktop\New folder'];
%indices         = [3375];
k = dir('E:\Final 36 set\K=4\Tri4_0.5*.tiff');
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

for pic=0
ind=(4*pic)+1;

%Phase map for triangular patters
% Image{1}=rgb2gray(im2double(imread('IMG_1444.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_1445.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_1446.tiff')));
% Image{4}=rgb2gray(im2double(imread('IMG_1447.tiff')));
Image{1}= Test{ind};
Image{2}= Test{ind+1};
Image{3}= Test{ind+2};
Image{4}= Test{ind+3};
% Image{1}= Test{pic};
% Image{2}= Test{30+pic};
% Image{3}= Test{60+pic};
% Image{4}= Test{60+pic};
% Image{1}= Test{28};
% Image{2}= Test{29};
% Image{3}= Test{30};
% Image{4}= Test{31};


m=size(Image{1},1);
n=size(Image{1},2);
N = 4;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
help(:,:,1)=Image{1};
help(:,:,2)=Image{2};
help(:,:,3)=Image{3};
help(:,:,4)=Image{4};
one=zeros(size(phi));
two=zeros(size(phi));
three=zeros(size(phi));
four=zeros(size(phi));
[b,I]=sort(help,3);
one=I(:,:,1);
two=I(:,:,2);
three=I(:,:,3);
four=I(:,:,4);
label_image=zeros(size(phi));
label_image(one==4&two==3&three==1&four==2)=1;
label_image(one==3&two==4&three==2&four==1)=2;
label_image(one==3&two==2&three==4&four==1)=3;
label_image(one==2&two==3&three==1&four==4)=4;
label_image(one==2&two==1&three==3&four==4)=5;
label_image(one==1&two==2&three==4&four==3)=6;
label_image(one==1&two==4&three==2&four==3)=7;
label_image(one==4&two==1&three==3&four==2)=8;
%column_correspondence=zeros(size(ma));
val=zeros(m,n);
val= ((Image{4}-Image{2})./((Image{3}-Image{1})));
for num = 0:1:8
    [a]=find(label_image==num);
    if (num ==1)         
        column_correspondence(a)=(pi)./(2*(1+val(a)));         
    end
    if(num==2)
        column_correspondence(a)=(pi)./(2*(1+val(a)));
    end
    if(num==3)
        column_correspondence(a)=((val(a)*2*pi)-pi)./(2*(val(a)-1));
    end
    if(num==4)
        column_correspondence(a)=((val(a)*2*pi)-pi)./(2*(val(a)-1));
    end
    if(num==5)
        column_correspondence(a)=((val(a)*2*pi)+(3*pi))./(2*(val(a)+1));
    end
    if(num==6)
        column_correspondence(a)=((val(a)*2*pi)+(3*pi))./(2*(val(a)+1));
    end
    if(num==7)
        column_correspondence(a)=((3*pi)-(val(a)*4*pi))./(2*(1-val(a)));
    end
    if(num==8)
        column_correspondence(a)=((3*pi)-(val(a)*4*pi))./(2*(1-val(a)));
    end
    if(num==0)
       
        for j=1:size(a,1)
            
                Q(1)=(Image{1}(a(j)));
                Q(2)=(Image{2}(a(j)));
                Q(3)=(Image{3}(a(j)));
                Q(4)=(Image{4}(a(j)));
                if ((abs(Q(1)-Q(4))<=0.004)&& (abs(Q(2)-Q(3))<=0.004))
                    if ((Q(1)>=0.006) && (Q(4)>=0.006))
                        column_correspondence(a(j))=((val(a(j)).*2*pi)-pi)./(2.*(val(a(j))-1));
                    else
                        column_correspondence(a(j))=((3*pi)-(val(a(j)).*4*pi))./(2.*(1-val(a(j))));                 
                    end
                end
                 if (abs(Q(1)-Q(2))<=0.004 && abs(Q(3)-Q(4))<=0.004)
                    if ((Q(1)>=0.005) &&(Q(2)>=0.005))                   
                        column_correspondence(a(j))=(pi)./(2.*(1+val(a(j))));                           
                    else                       
                        column_correspondence(a(j))=((val(a(j)).*2*pi)+(3*pi))./(2.*(val(a(j))+1));                    
                    end
                end
        end
    end
end
correspondence_tri{pic+1}=column_correspondence;
end
[m, n] = size(correspondence_tri{1}(1, :));
fig = plot(1:n, correspondence_tri{1}(1, :));
saveas(fig,'Tri4.png')