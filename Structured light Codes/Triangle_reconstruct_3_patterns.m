%dirname         = ['C:\Users\user\Desktop\New folder'];
%indices         = [3375];
k = dir('E:\Final 36 set\K=3\Tri3_0.1*.tiff');
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
ind=(3*pic)+1;

%Phase map for triangular patters
% Image{1}=rgb2gray(im2double(imread('IMG_0040.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_0041.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_0042.tiff')));
Image{1}= Test{ind};
Image{3}= Test{ind+1};
Image{2}= Test{ind+2};
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
med=zeros(size(ma));
med(ma+mi==3)=3;
med(ma+mi==4)=2;
med(ma+mi==5)=1;
label_image=zeros(size(ma));
label_image(med==1&mi==2&ma==3)=1;
label_image(ma==1&mi==2&med==3)=2;
label_image(ma==1&med==2&mi==3)=3;
label_image(med==1&ma==2&mi==3)=4;
label_image(mi==1&ma==2&med==3)=5;
label_image(mi==1&med==2&ma==3)=6;
%column_correspondence=zeros(size(ma));
val=zeros(m,n);
val= ((Image{1}-Image{3})./((2*Image{2})-Image{1}-Image{3}));

% for i = 0:1:6
%     [a,b]=find(label_image==i);
%     if (i ==1)
%          %val=((I(1)-I(3))/((2*I(2))-I(1)-I(3)));
%             if (val(a(j),b(j))>=(1/3))
%                 column_correspondence(a(j),b(j))=((((pi/3)-(pi*val(a(j),b(j))))/((1+val(a(j),b(j)))*2)));
%             else
%                  column_correspondence(a(j),b(j))=(((val(a(j),b(j))*3*pi)+(13*pi/3))/(2*(val(a(j),b(j))+1)));
%             end
%     end
%     if(i==2)
%         column_correspondence(a(j),b(j))=((((5*pi/3*val(a(j),b(j)))-(pi/3))/((val(a(j),b(j))-1)*2)));
%     end
%     if(i==3)
%         column_correspondence(a(j),b(j))=((((pi/3)+(4*(pi/3)*val(a(j),b(j))))/(2*val(a(j),b(j)))));
%     end
%     if(i==4)
%         column_correspondence(a(j),b(j))=(((7*pi/3)+(pi*val(a(j),b(j))))/(2*(val(a(j),b(j))+1)));
%     end
%     if(i==5)
%         column_correspondence(a(j),b(j))=(((7*pi/3)-(val(a(j),b(j))*11*pi/3))/(2*(1-val(a(j),b(j)))));
%     end
%     if(i==6)
%         column_correspondence(a(j),b(j))=(((10*pi/3*val(a(j),b(j)))+(pi/3))/(2*val(a(j),b(j))));
%     end
%     if(i==0)
%         for j=1:size(a,1)
%             
%                 I(1)=(Image{1}(a(j),b(j)));
%                 I(2)=(Image{3}(a(j),b(j)));
%                 I(3)=(Image{2}(a(j),b(j)));
%                 if (I(1)==I(3))
%                     num=I(3);
%                     if(num>0.2)
%                         
%                         column_correspondence(a(j),b(j))=((((pi/3)-(pi*val(a(j),b(j))))/((1+val(a(j),b(j)))*2)));
%                     else
%                        
%                         column_correspondence(a(j),b(j))=(((7*pi/3)+(pi*val(a(j),b(j))))/(2*(val(a(j),b(j))+1)));
%                     end
%                 end
%                 if (I(2)==I(3))
%                     num=I(2);
%                     if(num>0.2)
%                         
%                         column_correspondence(a(j),b(j))=(((7*pi/3)-(val(a(j),b(j))*11*pi/3))/(2*(1-val(a(j),b(j)))));
%                     else
%                         
%                         column_correspondence(a(j),b(j))=((((5*pi/3*val(a(j),b(j)))-(pi/3))/((val(a(j),b(j))-1)*2)));
%                     end
%                 end
%                 if(I(1)==I(2))
%                     num=I(1);
%                     if(num>0.2)
%                         
%                         column_correspondence(a(j),b(j))=((((pi/3)+(4*(pi/3)*val(a(j),b(j))))/(2*val(a(j),b(j)))));
%                     else
%                        column_correspondence(a(j),b(j))=(((10*pi/3*val(a(j),b(j)))+(pi/3))/(2*val(a(j),b(j)))); 
%                     end
%                 end
%         end
%     end
%     
% end
for i = 0:1:6
    [a]=find(label_image==i);
    if (i ==1)         
           for j=1:size(a,1)               
               b =((((pi/3)-(pi*val(a(j))))./((1+val(a(j)))*2)));
               if(b<0)
                   column_correspondence(a(j))=(((val(a(j))*3*pi)+(13*pi/3))./(2*(val(a(j))+1)));
               else
                   column_correspondence(a(j))=b;
               end
           end           
    end
    if(i==2)
        column_correspondence(a)=((((5*pi/3*val(a))-(pi/3))./((val(a)-1)*2)));
    end
    if(i==3)
        column_correspondence(a)=((((pi/3)+(4*(pi/3)*val(a)))./(2*val(a))));
    end
    if(i==4)
        column_correspondence(a)=(((7*pi/3)+(pi*val(a)))./(2*(val(a)+1)));
    end
    if(i==5)
        column_correspondence(a)=(((7*pi/3)-(val(a)*11*pi/3))./(2*(1-val(a))));
    end
    if(i==6)
        column_correspondence(a)=(((10*pi/3*val(a))+(pi/3))./(2*val(a)));
    end
    if(i==0)
       
        for j=1:size(a,1)
            
                I(1)=(Image{1}(a(j)));
                I(2)=(Image{3}(a(j)));
                I(3)=(Image{2}(a(j)));
                if (I(1)==I(3))
                    num=I(3);
                    if(num>0.2)
                        
                        column_correspondence(a(j))=((((pi/3)-(pi*val(a(j))))./((1+val(a(j)))*2)));
                    else
                       
                        column_correspondence(a(j))=(((7*pi/3)+(pi*val(a(j))))./(2*(val(a(j))+1)));
                    end
                end
                if (I(2)==I(3))
                    num=I(2);
                    if(num>0.2)
                        
                        column_correspondence(a(j))=(((7*pi/3)-(val(a(j))*11*pi/3))./(2*(1-val(a(j)))));
                    else
                        
                        column_correspondence(a(j))=((((5*pi/3*val(a(j)))-(pi/3))./((val(a(j))-1)*2)));
                    end
                end
                if(I(1)==I(2))
                    num=I(1);
                    if(num>0.2)
                        
                        column_correspondence(a(j))=((((pi/3)+(4*(pi/3)*val(a(j))))./(2*val(a(j)))));
                    else
                       column_correspondence(a(j))=(((10*pi/3*val(a(j)))+(pi/3))./(2*val(a(j)))); 
                    end
                end
        end
    end
    
end
correspondence_tri{pic+1}=column_correspondence;
end

[m1, n1] = size(correspondence_tri{1}(1, :));
fig = plot(1:n1, correspondence_tri{1}(1, :));
saveas(fig,'Tri3.png')
save('Triangle.mat','correspondence_tri','-v7.3');


for pic=1:30
% ind=(3*pic)+1;

%Phase map for triangular patters
% Image{1}=rgb2gray(im2double(imread('IMG_0040.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_0041.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_0042.tiff')));
% Image{1}= Test{ind};
% Image{3}= Test{ind+1};
% Image{2}= Test{ind+2};
Image{1}= Test{pic};
Image{3}= Test{30+pic};
Image{2}= Test{60+pic};
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
med=zeros(size(ma));
med(ma+mi==3)=3;
med(ma+mi==4)=2;
med(ma+mi==5)=1;
label_image=zeros(size(ma));
label_image(med==1&mi==2&ma==3)=1;
label_image(ma==1&mi==2&med==3)=2;
label_image(ma==1&med==2&mi==3)=3;
label_image(med==1&ma==2&mi==3)=4;
label_image(mi==1&ma==2&med==3)=5;
label_image(mi==1&med==2&ma==3)=6;
%column_correspondence=zeros(size(ma));
val=zeros(m,n);
val= ((Image{1}-Image{3})./((2*Image{2})-Image{1}-Image{3}));
for i = 0:1:6
    [a]=find(label_image==i);
    if (i ==1)         
           for j=1:size(a,1)               
               b =((((pi/3)-(pi*val(a(j))))./((1+val(a(j)))*2)));
               if(b<0)
                   column_correspondence(a(j))=(((val(a(j))*3*pi)+(13*pi/3))./(2*(val(a(j))+1)));
               else
                   column_correspondence(a(j))=b;
               end
           end           
    end
    if(i==2)
        column_correspondence(a)=((((5*pi/3*val(a))-(pi/3))./((val(a)-1)*2)));
    end
    if(i==3)
        column_correspondence(a)=((((pi/3)+(4*(pi/3)*val(a)))./(2*val(a))));
    end
    if(i==4)
        column_correspondence(a)=(((7*pi/3)+(pi*val(a)))./(2*(val(a)+1)));
    end
    if(i==5)
        column_correspondence(a)=(((7*pi/3)-(val(a)*11*pi/3))./(2*(1-val(a))));
    end
    if(i==6)
        column_correspondence(a)=(((10*pi/3*val(a))+(pi/3))./(2*val(a)));
    end
    if(i==0)
       
        for j=1:size(a,1)
            
                I(1)=(Image{1}(a(j)));
                I(2)=(Image{3}(a(j)));
                I(3)=(Image{2}(a(j)));
                if (I(1)==I(3))
                    num=I(3);
                    if(num>0.2)
                        
                        column_correspondence(a(j))=((((pi/3)-(pi*val(a(j))))./((1+val(a(j)))*2)));
                    else
                       
                        column_correspondence(a(j))=(((7*pi/3)+(pi*val(a(j))))./(2*(val(a(j))+1)));
                    end
                end
                if (I(2)==I(3))
                    num=I(2);
                    if(num>0.2)
                        
                        column_correspondence(a(j))=(((7*pi/3)-(val(a(j))*11*pi/3))./(2*(1-val(a(j)))));
                    else
                        
                        column_correspondence(a(j))=((((5*pi/3*val(a(j)))-(pi/3))./((val(a(j))-1)*2)));
                    end
                end
                if(I(1)==I(2))
                    num=I(1);
                    if(num>0.2)
                        
                        column_correspondence(a(j))=((((pi/3)+(4*(pi/3)*val(a(j))))./(2*val(a(j)))));
                    else
                       column_correspondence(a(j))=(((10*pi/3*val(a(j)))+(pi/3))./(2*val(a(j)))); 
                    end
                end
        end
    end
    
end
correspondence_tri2{pic}=column_correspondence;
end
