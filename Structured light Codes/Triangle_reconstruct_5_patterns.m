%dirname         = ['C:\Users\user\Desktop\New folder'];
%indices         = [3375];
k = dir('E:\16 bit images(4&5)\Tri5\*.tiff');
filenames = {k.name}';
for num=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
     fname=k(num).name;
     Test{num}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

for pic=0:15
ind=(5*pic)+1;

%Phase map for triangular patters
% Image{1}=rgb2gray(im2double(imread('IMG_1448.tiff')));
% Image{2}=rgb2gray(im2double(imread('IMG_1449.tiff')));
% Image{3}=rgb2gray(im2double(imread('IMG_1450.tiff')));
% Image{4}=rgb2gray(im2double(imread('IMG_1451.tiff')));
% Image{5}=rgb2gray(im2double(imread('IMG_1452.tiff')));
Image{1}= Test{ind};
Image{2}= Test{ind+1};
Image{3}= Test{ind+2};
Image{4}= Test{ind+3};
Image{5}= Test{ind+4};
% Image{1}= Test{pic};
% Image{2}= Test{30+pic};
% Image{3}= Test{60+pic};
% Image{4}= Test{60+pic};
% Image{5}= Test{60+pic};
% Image{1}= Test{32};
% Image{2}= Test{33};
% Image{3}= Test{34};
% Image{4}= Test{35};
% Image{5}=Test{36};

% for k=1:N
% Image{k}=(Image{k}*pi)-(pi/2);
% end
N = 5;
m=size(Image{1},1);
n=size(Image{1},2);
phi = zeros(m,n);
column_correspondence=zeros(m,n);
help(:,:,1)=Image{1};
help(:,:,2)=Image{2};
help(:,:,3)=Image{3};
help(:,:,4)=Image{4};
help(:,:,5)=Image{5};
one=zeros(size(phi));
two=zeros(size(phi));
three=zeros(size(phi));
four=zeros(size(phi));
five=zeros(size(phi));
[b,I]=sort(help,3);
one=I(:,:,1);
two=I(:,:,2);
three=I(:,:,3);
four=I(:,:,4);
five=I(:,:,5);
label_image=zeros(size(phi));
label_image(one==5&two==4&three==1&four==3&five==2)=1;
label_image(one==4&two==5&three==3&four==1&five==2)=2;
label_image(one==4&two==3&three==5&four==2&five==1)=3;
label_image(one==3&two==4&three==2&four==5&five==1)=4;
label_image(one==3&two==2&three==4&four==1&five==5)=5;
label_image(one==2&two==3&three==1&four==4&five==5)=6;
label_image(one==2&two==1&three==3&four==5&five==4)=7;
label_image(one==1&two==2&three==5&four==3&five==4)=8;
label_image(one==1&two==5&three==2&four==4&five==3)=9;
label_image(one==5&two==1&three==4&four==2&five==3)=10;
%label_image(one==5&two==4&three==1&four==3&five==2)=11;
%column_correspondence=zeros(size(ma));
% val=zeros(m,n);
% val= ((Image{5}-Image{2}+Image{1})./((Image{4}-Image{3}-Image{1})));
% for num = 0:1:10
%     [a]=find(label_image==num);
%     if (num ==1)         
%           for j=1:size(a,1)               
%                b =((4*pi/5)-(val(a(j))*2*pi/5))./(val(a(j))+1);
%                if(b<0)
%                    column_correspondence(a(j))=((14*pi/5)+(val(a(j))*8*pi/5))./(val(a(j))+1);
%                else
%                    column_correspondence(a(j))=b;
%                end
%            end                
%     end
%     if(num==2)
%         column_correspondence(a)=(-(2*pi/5*val(a))+pi)./(3+val(a));
%     end
%     if(num==3)
%         column_correspondence(a)=(-pi+(pi*val(a)))./(val(a)-3);
%     end
%     if(num==4)
%         column_correspondence(a)=(val(a)*2*pi)./((3*val(a))-1);
%     end
%     if(num==5)
%         column_correspondence(a)=(3*pi/5*val(a))./(val(a)-1);
%     end
%     if(num==6)
%         column_correspondence(a)=((9*pi/5)+(val(a)*3*pi/5))./(val(a)+1);
%     end
%     if(num==7)
%         column_correspondence(a)=((4*pi)+(val(a)*3*pi/5))./(val(a)+3);
%     end
%     if(num==8)
%         column_correspondence(a)=((val(a)*2*pi)-(4*pi))./(val(a)-3);
%     end
%     if(num==9)
%         column_correspondence(a)=(pi-(val(a)*5*pi))./(1-(3*val(a)));
%     end
%     if(num==10)
%         column_correspondence(a)=(pi-(val(a)*8*pi/5))./(1-val(a));
%     end
%     if(num==0)
%        
%         for j=1:size(a,1)
%             
%                 Q(1)=(Image{1}(a(j)));
%                 Q(2)=(Image{2}(a(j)));
%                 Q(3)=(Image{3}(a(j)));
%                 Q(4)=(Image{4}(a(j)));
%                 Q(5)=(Image{5}(a(j)));
%                 if (round(Q(3),2)==round(Q(4),2)&&round(Q(5),2)==round(Q(2),2))
%                    column_correspondence(a(j))=(-pi+(pi*val(a(j))))./(val(a(j))-3);
%                 end
%                 if (round(Q(2),2)==round(Q(3),2)&&round(Q(1),2)==round(Q(4),2))
%                    column_correspondence(a(j))=(3*pi/5*val(a(j)))./(val(a(j))-1);
%                 end
%                     
%         end
%     end
% end
% correspondence_tri2{pic}=column_correspondence;
% end
M1=[1 1 0; 1  1 2*pi/5;1 -1 pi/5; 1 -1 -pi/5; 1 1 -2*pi/5];
M2=[1 1 0; 1 -1 3*pi/5; 1 -1 pi/5; 1 -1 -pi/5; 1 1 -2*pi/5];
M3=[1 1 0; 1 -1 3*pi/5; 1 -1 pi/5; 1 1 -4*pi/5;1 1 -2*pi/5];
M4=[1 -1 pi; 1 -1 3*pi/5; 1 -1 pi/5; 1 1 -4*pi/5; 1 1 -2*pi/5];
M5=[1 -1 pi; 1 -1 3*pi/5; 1 1 -6*pi/5; 1 1 -4*pi/5; 1 1 -2*pi/5];
M6=[1 -1 pi; 1 -1 3*pi/5; 1 1 -6*pi/5; 1 1 -4*pi/5; 1 -1 7*pi/5];
M7=[1 -1 pi; 1 1 -8*pi/5; 1 1 -6*pi/5; 1 1 -4*pi/5; 1 -1 7*pi/5];
M8=[1 -1 pi; 1 1 -8*pi/5; 1 1 -6*pi/5; 1 -1 9*pi/5; 1 -1 7*pi/5];
M9=[1 1 -2*pi; 1 1 -8*pi/5; 1 1 -6*pi/5; 1 -1 9*pi/5; 1 -1 7*pi/5];
M10=[ 1 1 -2*pi; 1 1 -8*pi/5; 1 -1 11*pi/5; 1 -1 9*pi/5; 1 -1 7*pi/5];
M11=[ 1 1 -2*pi; 1 1 -8*pi/5; 1 -1 11*pi/5;1 -1 9*pi/5; 1 1 -12*pi/5];
M1=pinv(M1);
M2=pinv(M2);
M3=pinv(M3);
M4=pinv(M4);
M5=pinv(M5);
M6=pinv(M6);
M7=pinv(M7);
M8=pinv(M8);
M9=pinv(M9);
M10=pinv(M10);
M11=pinv(M11);
x1=reshape(help,(m*n),5);
X1=M1*x1';
v1=X1(3,:);
u1=X1(2,:);
phi1=u1./v1;
phi1=reshape(phi1,m,n);

x2=reshape(help,(m*n),5);
X2=M2*x2';
v2=X2(3,:);
u2=X2(2,:);
phi2=u2./v2;
phi2=reshape(phi2,m,n);

x3=reshape(help,(m*n),5);
X3=M3*x3';
v3=X3(3,:);
u3=X3(2,:);
phi3=u3./v3;
phi3=reshape(phi3,m,n);

x4=reshape(help,(m*n),5);
X4=M4*x4';
v4=X4(3,:);
u4=X4(2,:);
phi4=u4./v4;
phi4=reshape(phi4,m,n);

x5=reshape(help,(m*n),5);
X5=M5*x5';
v5=X5(3,:);
u5=X5(2,:);
phi5=u5./v5;
phi5=reshape(phi5,m,n);

x6=reshape(help,(m*n),5);
X6=M6*x6';
v6=X6(3,:);
u6=X6(2,:);
phi6=u6./v6;
phi6=reshape(phi6,m,n);

x7=reshape(help,(m*n),5);
X7=M7*x7';
v7=X7(3,:);
u7=X7(2,:);
phi7=u7./v7;
phi7=reshape(phi7,m,n);

x8=reshape(help,(m*n),5);
X8=M8*x8';
v8=X8(3,:);
u8=X8(2,:);
phi8=u8./v8;
phi8=reshape(phi8,m,n);

x9=reshape(help,(m*n),5);
X9=M9*x9';
v9=X9(3,:);
u9=X9(2,:);
phi9=u9./v9;
phi9=reshape(phi9,m,n);

x10=reshape(help,(m*n),5);
X10=M10*x10';
v10=X10(3,:);
u10=X10(2,:);
phi10=u10./v10;
phi10=reshape(phi10,m,n);

x11=reshape(help,(m*n),5);
X11=M11*x11';
v11=X11(3,:);
u11=X11(2,:);
phi11=u11./v11;
phi11=reshape(phi11,m,n);

for num = 0:1:10
    [a]=find(label_image==num);
    if (num ==1)         
          column_correspondence(a)=phi1(a);
           for j=1:size(a,1)               
               b =column_correspondence(a(j));
               if(b<0)
                   column_correspondence(a(j))=phi11(a(j));
               end
           end    
    end
    if(num==2)
        column_correspondence(a)=phi2(a);
    end
    if(num==3)
        column_correspondence(a)=phi3(a);
    end
    if(num==4)
        column_correspondence(a)=phi4(a);
    end
    if(num==5)
        column_correspondence(a)=phi5(a);
    end
    if(num==6)
        column_correspondence(a)=phi6(a);
    end
    if(num==7)
       column_correspondence(a)=phi7(a);
    end
    if(num==8)
         column_correspondence(a)=phi8(a);
    end
    if(num==9)
        column_correspondence(a)=phi9(a);
    end
    if(num==10)
        column_correspondence(a)=phi10(a);
    end
    if(num==0)
       
        for j=1:size(a,1)
            
                Q(1)=(Image{1}(a(j)));
                Q(2)=(Image{2}(a(j)));
                Q(3)=(Image{3}(a(j)));
                Q(4)=(Image{4}(a(j)));
                Q(5)=(Image{5}(a(j)));
                if (abs(round(Q(1),2)-round(Q(3),2))<=0.03&&abs(round(Q(4),2)-round(Q(5),2))<=0.03)
                   if (Q(4)&&Q(5)<0.06)
                       column_correspondence(a(j))=phi1(a(j)); 
                   else
                       column_correspondence(a(j))=phi6(a(j)); 
                   end
                end
                if (abs(round(Q(1),2)-round(Q(2),2))<=0.03&&abs(round(Q(3),2)-round(Q(5),2))<=0.03)
                   if (Q(1)&&Q(2)>0.06)
                       column_correspondence(a(j))=phi2(a(j)); 
                   else
                       column_correspondence(a(j))=phi7(a(j)); 
                   end
                end
                if (abs(round(Q(2),2)-round(Q(5),2))<=0.03&&abs(round(Q(3),2)-round(Q(4),2))<=0.03)
                   if (Q(3)&&Q(4)<0.06)
                       column_correspondence(a(j))=phi3(a(j)); 
                   else
                       column_correspondence(a(j))=phi8(a(j)); 
                   end
                end
                if (abs(round(Q(1),2)-round(Q(5),2))<=0.03&&abs(round(Q(2),2)-round(Q(4),2))<=0.03)
                   if (Q(1)&&Q(5)>0.06)
                       column_correspondence(a(j))=phi4(a(j)); 
                   else
                       column_correspondence(a(j))=phi9(a(j)); 
                   end
                end
                if (abs(round(Q(1),2)-round(Q(4),2))<=0.03&&abs(round(Q(2),2)-round(Q(3),2))<=0.03)
                   if (Q(1)&&Q(4)>0.06)
                       column_correspondence(a(j))=phi5(a(j)); 
                   else
                       column_correspondence(a(j))=phi10(a(j)); 
                   end
                end
                    
        end
    end
end
column_correspondence(column_correspondence>7)=0;
column_correspondence(column_correspondence<0)=0;
correspondence_tri{pic+1}=column_correspondence;
end
