%Projecting different patterns
%Assume op=0 and ap = 1 in all patterns

% N = 3;
N= 4;
N= 5;
m = 1080;
%m=600;
n = 1920;
%n=800;
op = 0;
ap = 1;
%p = zeros(m,10*n);
p = zeros(m,n);
%Ramp patterns
p1 = zeros(m,n);
p2 = zeros(m,n);
p3 = zeros(m,n);

    for xl = 1:n
        p1(1:m,xl) =  ones(m,1);
    end
    for xl = 1:n
        p2(1:m,xl) =  0.5+ ones(m,1) * sawtooth(2*pi*xl/n)*0.5;
    end
    for xl = 1:n
        p3(1:m,xl) =  zeros(m,1);
    end
 %Opposing Ramp and 0
 
p1 = zeros(m,n);
p2 = zeros(m,n);
p3 = zeros(m,n);

    for xl = 1:n
        p1(1:m,xl) =  0.5+ ones(m,1) * sawtooth(2*pi*xl/n)*0.5;
    end
    j=1;
    for xl = n:-1:1
        p2(1:m,j) =  0.5+ ones(m,1) * sawtooth(2*pi*xl/n)*0.5;
        j=j+1;
    end
    for xl = 1:n
        p3(1:m,xl) =  zeros(m,1);
    end
 %Opposing Ramp and 1
 
p1 = zeros(m,n);
p2 = zeros(m,n);
p3 = zeros(m,n);

    for xl = 1:n
        p1(1:m,xl) =  ones(m,1);
    end
    
    for xl = 1:n
        p2(1:m,xl) =  0.5+ ones(m,1) * sawtooth(2*pi*xl/n)*0.5;
    end
    
    j=1;
    for xl = n:-1:1
        p3(1:m,j) =  0.5+ ones(m,1) * sawtooth(2*pi*xl/n)*0.5;
        j=j+1;
    end
   
%sinusoidal patterns
for a = 1:N
    for xl = 1:n
        p(1:m,xl) = 0.5+ ones(m,1) * cos(2*pi*xl/n + 2*pi*(a-1)/N)*0.5;
    end
    P{a} = p;
end
% P{1}=(P{1}+1)/2;
% P{2}=(P{2}+1)/2;
% P{3}=(P{3}+1)/2;
%triangular wave patterns
for a = 1:N
    for xl = 1:n
        p(1:m,xl) = ones(m,1) * asin(sin(2*pi*xl/n + 2*pi*(a-1)/N));
    end
    P{a} = p;
end
for i=1:N
    P{i}=(P{i}+pi/2)/pi;
end
% P{1}=(P{1}+pi/2)/pi;
% P{2}=(P{2}+pi/2)/pi;
% P{3}=(P{3}+pi/2)/pi;
%Sawtooth wave patterns
for a = 1:N
    for xl = 1:n
        p(1:m,xl) = 0.5+ ones(m,1) * sawtooth(2*pi*xl/n + 2*pi*(a-1)/N)*0.5;
    end
    P{a} = p;
end
% P{1}=(P{1}+1)/2;
% P{2}=(P{2}+1)/2;
% P{3}=(P{3}+1)/2;
%Hamiltonian cube
P{1}=zeros(m,n);
P{2}=zeros(m,n);
P{3}=zeros(m,n);
 for xl = 1:n
     a= 2*pi*xl/n;
     
        if (a >=0 && a <=1)
            
            P{1}(1:m,xl) =2*pi*xl/n;
            P{2}(1:m,xl)=1;
            P{3}(1:m,xl)=0;
        end
        if(a >1 &&a  <=2)
            
            P{1}(1:m,xl) = 1;
            P{2}(1:m,xl)=(1-(2*pi*xl/n-1));
            P{3}(1:m,xl)=0;
        end
        if(a >2 &&a  <=3)
           
           P{1}(1:m,xl) = 1;
           P{2}(1:m,xl)=0;
           P{3}(1:m,xl)=(2*pi*xl/n-2); 
        end
        if(a >3&&a <=4)
           
            P{1}(1:m,xl) =(1-(2*pi*xl/n-3));
           P{2}(1:m,xl)=0;
           P{3}(1:m,xl)=1;
        end
        if(a >4&&a<=5)
           
            P{1}(1:m,xl) =0;
           P{2}(1:m,xl)=(2*pi*xl/n-4);
           P{3}(1:m,xl)=1;
        end
        if(a >5 && a<=6)
          
            P{1}(1:m,xl)=0;
           P{2}(1:m,xl)=1;
           P{3}(1:m,xl)=(1-(2*pi*xl/n-5));
    
        end
        
 end
%Corrected 
P{1}=zeros(m,n);
P{2}=zeros(m,n);
P{3}=zeros(m,n);
patch = round(n/6);
 for xl = 1:n
     
     a= (xl/patch);
        if (a >=0 && a <=1)
            
            P{1}(1:m,xl) =xl/patch;
            P{2}(1:m,xl)=1;
            P{3}(1:m,xl)=0;
        end
        if(a >1 &&a  <=2)
            
            P{1}(1:m,xl) = 1;
            P{2}(1:m,xl)=1-(xl-(1*patch))/patch;
            P{3}(1:m,xl)=0;
        end
        if(a >2 &&a  <=3)
           
           P{1}(1:m,xl) = 1;
           P{2}(1:m,xl)=0;
           P{3}(1:m,xl)=(xl-(2*patch))/patch; 
        end
        if(a >3&&a <=4)
           
           P{1}(1:m,xl) =1-(xl-(3*patch))/patch;
           P{2}(1:m,xl)=0;
           P{3}(1:m,xl)=1;
        end
        if(a >4&&a<=5)
           
           P{1}(1:m,xl) =0;
           P{2}(1:m,xl)=(xl-(4*patch))/patch;
           P{3}(1:m,xl)=1;
        end
        if(a >5 && a<=6)
          
           P{1}(1:m,xl)=0;
           P{2}(1:m,xl)=1;
           P{3}(1:m,xl)=1-(xl-(5*patch))/patch;
    
        end
        
 end
 %Image size = (400,477)
 
 %scaling,converting and saving images
x = ((0:255)/255);
for ii=1:size(p1,1)
for jj=1:size(p1,2)
y=abs(p1(ii,jj)-x);
a= (find(y == min(y))-1);
diff(ii,jj)=a(1);
corrected_gray(ii,jj)=value(a(1)+1)/255; %Radiometric cali applied using grayscale
%corrected_rgb(ii,jj,1)=(valueR(a(1)+1)/255);
%corrected_rgb(ii,jj,2)=(valueG(a(1)+1)/255);
%corrected_rgb(ii,jj,3)=(valueB(a(1)+1)/255); %Radimetric cali applied using R,G,B.
end
end
corrected_gray=im2uint16(corrected_gray);



% Pc{1}=zeros(size(P{1}));
% Pc{2}=zeros(size(P{2}));
% Pc{3}=zeros(size(P{3}));
% for ii=1:size(P{1},1)
% for jj=1:size(P{1},2)
%     Pc{1}(ii,jj)=polyval(poly,P{1}(ii,jj));
%     Pc{2}(ii,jj)=polyval(poly,P{2}(ii,jj));
%     Pc{3}(ii,jj)=polyval(poly,P{3}(ii,jj));
% end
% end
% Pc{1}=zeros(size(P{1}));
% Pc{2}=zeros(size(P{2}));
% Pc{3}=zeros(size(P{3}));
% for ii=1:size(P{1},1)
% for jj=1:size(P{1},2)
%     poly1=poly;
%     poly2=poly;
%     poly3=poly;
%     poly1(end)=poly1(end)-P{1}(ii,jj);
%     poly2(end)=poly2(end)-P{2}(ii,jj);
%     poly3(end)=poly3(end)-P{3}(ii,jj);
%     one = roots(poly1);
%     two=roots(poly2);
%     three = roots(poly3);
%     Pc{1}(ii,jj)=one(4);
%     Pc{2}(ii,jj)=two(4);
%     Pc{3}(ii,jj)=three(4);
% end
% end


%Phase map for sine
Image{1}=imread('IMG_0506.tiff');
Image{2}=imread('IMG_0507.tiff');
Image{3}=imread('IMG_0508.tiff');
m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
for p = 1:m
    for q = 1:n
        I = [];
        %for num = 1:N
        %I = [I, Image{num}(p,q)];
        %end
        I(1)=(Image{1}(p,q));
         I(2)=(Image{2}(p,q));
         I(3)=(Image{3}(p,q));
        %I(1)=(Image{1}(p,q)*2)-1;
         %I(2)=(Image{2}(p,q)*2)-1;
         %I(3)=(Image{3}(p,q)*2)-1;
        I = I';
        I=double(I);
        for i = 1:N
            M(i,:) = [1 cos(2*pi*(i-1)/N) -sin(2*pi*(i-1)/N)];
        end
        X = pinv(M)*I;
        if X(3) >= 0
            phi_p = acos(X(2)/sqrt(X(2)^2 + X(3)^2));
        else 
            phi_p = 2*pi - acos(X(2)/sqrt(X(2)^2 + X(3)^2));
        end
        phi(p,q) = phi_p; 
    end
end
%Phase map for triangular patters
Image{1}=rgb2gray(im2double(imread('IMG_0509.tiff')));
Image{2}=rgb2gray(im2double(imread('IMG_0510.tiff')));
Image{3}=rgb2gray(im2double(imread('IMG_0511.tiff')));
%Image{1}=Image{1}/max(Image{1}(:));
%Image{2}=Image{2}/max(Image{2}(:));
%Image{3}=Image{3}/max(Image{3}(:));
m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
%When scaled from 0-1
for p = 1:m
    for q = 1:n
        I = [];
        %for num = 1:N
        %I = [I, Image{num}(p,q)];
        %end
        %I(1)=(Image{1}(p,q)*pi)-pi/2;
        %I(2)=(Image{3}(p,q)*pi)-pi/2;
        %I(3)=(Image{2}(p,q)*pi)-pi/2;
         I(1)=(Image{1}(p,q));
         I(2)=(Image{3}(p,q));
         I(3)=(Image{2}(p,q));
        Im= median(I);
        m=I==Im;
        med=find(m); 
        [v,ma]= max(I);
        [v2,mi]= min(I);
        a=Im~=0 ;
        b=max(I)~=0;
       % slope = (((asin(sin(2*pi*2/n))-asin(sin(2*pi/n)))+pi/2)/pi)-0.5;
       val=((I(1)-I(3))/((2*I(2))-I(1)-I(3)));
        if(a && b)
            if (length(unique(I))==numel(I))
                if((med==1&&mi==2&&ma==3))              
                    value=((((pi/3)-(pi*val))/((1+val)*2)));
                    if (value<0)
                        value=(((val*3*pi)+(13*pi/3))/(2*(val+1)));
                    end
                    column_correspondence(p,q)=value*(1920/6.28);
                end
                if((ma==1&&mi==2&&med==3))  
                    value=((((5*pi/3*val)-(pi/3))/((val-1)*2)));
                    column_correspondence(p,q)=value*(1920/6.28);
                end
                if((ma==1&&med==2&&mi==3))  
                    value=((((pi/3)+(4*(pi/3)*val))/(2*val)));
                    column_correspondence(p,q)=value*(1920/6.28);
                end
                if ((med==1&&ma==2&&mi==3))
                    value=(((7*pi/3)+(pi*val))/(2*(val+1)));
                    column_correspondence(p,q)=value*(1920/6.28);
                end
                if ((mi==1&&ma==2&&med==3))
                    value=(((7*pi/3)-(val*11*pi/3))/(2*(1-val)));
                    column_correspondence(p,q)=value*(1920/6.28);
                end
                if ((mi==1&&med==2&&ma==3))
                    value=(((10*pi/3*val)+(pi/3))/(2*val));
                    column_correspondence(p,q)=value*(1920/6.28);
                end
            else
                if (I(1)==I(3))
                    num=I(3);
                    if(num>0.2)
                        value=((((pi/3)-(pi*val))/((1+val)*2)));
                        column_correspondence(p,q)=value*(1920/6.28);
                    else
                        value=(((7*pi/3)+(pi*val))/(2*(val+1)));
                        column_correspondence(p,q)=value*(1920/6.28);
                    end
                end
                if (I(2)==I(3))
                    num=I(2);
                    if(num>0.2)
                        value=(((7*pi/3)-(val*11*pi/3))/(2*(1-val)));
                        column_correspondence(p,q)=value*(1920/6.28);
                    else
                        value=((((5*pi/3*val)-(pi/3))/((val-1)*2)));
                        column_correspondence(p,q)=value*(1920/6.28);
                    end
                end
                if(I(1)==I(2))
                    num=I(1);
                    if(num>0.2)
                        value=((((pi/3)+(4*(pi/3)*val))/(2*val)));
                        column_correspondence(p,q)=value*(1920/6.28);
                    else
                       value=(((10*pi/3*val)+(pi/3))/(2*val));
                        column_correspondence(p,q)=value*(1920/6.28); 
                    end
                end
                 %column_correspondence(p,q)=0;
            end
        else
        column_correspondence(p,q)=0;
        end
     end
end
phi=(2*pi*column_correspondence)/1920;
%When not scaled
for p = 1:m
    for q = 1:n
        I = [];
        for num = 1:N
        I = [I, Image{num}(p,q)];
        end
        Im= median(I);
        m=I==Im;
        med=find(m); 
        [v,ma]= max(I);
        [v2,mi]= min(I);
        a=Im~=0 ;
        b=max(I)~=0;
        if(a && b)
            if (length(unique(I))==numel(I))
                if((med==1&&ma==2&&mi==3)||(ma==1&&med==2&&mi==3))
                    phi(p,q)=I(1)/asin(sin(2*pi/n));
                end
                if((ma==1&&mi==2&&med==3)||(med==1&&mi==2&&ma==3)||(mi==1&&med==2&&ma==3))
                    diff=1.57-I(1);
                    phi(p,q)=(diff+1.57)/asin(sin(2*pi/n));
                end
                if(mi==1&&ma==2&&med==3)
                    diff=-1.57+I(1);
                    phi(p,q)=(4.71-diff)/asin(sin(2*pi/n));
                end
            else 
                phi(p,q)=0;
            end
        else
            phi(p,q)=0;
        end
    end
end
%Sawtooth phase map
%When scaled from 0 -1
Image{1}=rgb2gray(im2double(imread('IMG_0043.tiff')));
Image{2}=rgb2gray(im2double(imread('IMG_0044.tiff')));
Image{3}=rgb2gray(im2double(imread('IMG_0045.tiff')));
%Image{1}=Image{1}/max(Image{1}(:));
%Image{2}=Image{2}/max(Image{2}(:));
%Image{3}=Image{3}/max(Image{3}(:));

m=size(Image{1},1);
n=size(Image{1},2);
%n=1920;
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
for p = 1:m
    for q = 1:n
        I = [];
         I(1)=(Image{1}(p,q));
         I(2)=(Image{2}(p,q));
         I(3)=(Image{3}(p,q));
%         I(1)=(Image{1}(p,q));
%         I(2)=(Image{3}(p,q));
%         I(3)=(Image{2}(p,q));
        Im= median(I);
        m=I==Im;
        med=find(m); 
        [v,ma]= max(I);
        [v2,mi]= min(I);
        a=Im~=0 ;
        b=max(I)~=0;
        
        if(a && b)
            if (length(unique(I))==numel(I))
                if(mi==1&&ma==3&&med==2)
                    %alpha=((I(2)-I(1))*1.5);
                    %alpha=((I(2)-I(1))/0.3333);
                    alpha=((I(3)-I(1))/0.6667);
                    value=((I(1)*2*pi)/alpha);
                    column_correspondence(p,q)=abs(value)*(1920/6.28);
                end
                if(med==1&&mi==3&&ma==2)
%                   alpha=(I(2)-I(1))*1.5;
                    %alpha=((I(2)-I(1))/0.333);
                    alpha=((I(3)-I(1))/-0.3333);
                    value=((I(1)*2*pi)/alpha);
                    column_correspondence(p,q)=abs(value)*(1920/6.28);
                end
                if(ma==1&&med==3&&mi==2)
%                     alpha=(I(2)-I(1))*(-0.75);
                    alpha=((I(2)-I(1))/-0.6667);
                    %alpha=((I(3)-I(1))/-0.3333);
                    value=((I(1)*2*pi)/alpha);
                    column_correspondence(p,q)=abs(value)*(1920/6.28);
                end
            else
                column_correspondence(p,q)= 0;
            end
        else
            column_correspondence(p,q)= 0;
        end
    end
end
phi=(2*pi*column_correspondence)/1920;
  
%TEST%
for p = 1:m/2+1
    for q = 300:1200
        I = [];
         I(1)=(Image{1}(p,q)*2)-1;
         I(3)=(Image{2}(p,q)*2)-1;
         I(2)=(Image{3}(p,q)*2)-1;
%         I(1)=(Image{1}(p,q));
%         I(2)=(Image{3}(p,q));
%         I(3)=(Image{2}(p,q));
        Im= median(I);
        m=I==Im;
        med=find(m); 
        [v,ma]= max(I);
        [v2,mi]= min(I);
        a=Im~=0 ;
        b=max(I)~=0;
        
        if(a && b)
            if (length(unique(I))==numel(I))
                if(mi==1&&ma==2&&med==3)
                    %alpha=((I(2)-I(1))*1.5);
                    alpha=((I(3)-I(2))*1.5);
                    value=(I(2)-I(1)-((8/3)*alpha))*(-pi/(2));
                    column_correspondence(p,q)=abs(value)*(1920/6.28);
                end
                
            else
                column_correspondence(p,q)= 0;
            end
        else
            column_correspondence(p,q)= 0;
        end
    end
end
%Phase map for Hamiltonian cycle of cube
Image{1}=rgb2gray(im2double(imread('IMG_0046.tiff')));
Image{2}=rgb2gray(im2double(imread('IMG_0076.tiff')));
Image{3}=rgb2gray(im2double(imread('IMG_0106.tiff')));
%Image{1}=Image{1}/max(Image{1}(:));
%Image{2}=Image{2}/max(Image{2}(:));
%Image{3}=Image{3}/max(Image{3}(:));
m=size(Image{1},1);
n=size(Image{1},2);
N = 3;
phi = zeros(m,n);
column_correspondence=zeros(m,n);
for p = 1:m
    for q = 1:n
        I = [];
        for num = 1:N
        I = [I, Image{num}(p,q)];
        end
        Im= median(I);
        m=I==Im;
        med=find(m); 
        [v,ma]= max(I);
        [v2,mi]= min(I);
        a=Im~=0 ;
        b=max(I)~=0;
        patch=(3720-881)/6;
        slope = 6/(3720-881);
        if(a && b)
            if (length(unique(I))==numel(I))
                if(med==1&&ma==2&&mi==3)
                    column_correspondence(p,q)=((I(med)-I(mi))/(I(ma)-I(mi)))*(1920/6);
                end
                if(ma==1&&med==2&&mi==3)
                    column_correspondence(p,q) = (1+1-(I(med)-I(mi))/(I(ma)-I(mi)))*(1920/6);
                end
                if(ma==1&&mi==2&&med==3)
                    column_correspondence(p,q)=(2+(I(med)-I(mi))/(I(ma)-I(mi)))*(1920/6);
                end
                if(med==1&&mi==2&&ma==3)
                    column_correspondence(p,q)=(3+1-(I(med)-I(mi))/(I(ma)-I(mi)))*(1920/6);
                end
                if(mi==1&&med==2&&ma==3)
                    column_correspondence(p,q)=(4+(I(med)-I(mi))/(I(ma)-I(mi)))*(1920/6);
                end
                if(mi==1&&ma==2&&med==3)
                    column_correspondence(p,q)= (5+1-(I(med)-I(mi))/(I(ma)-I(mi)))*(1920/6);
                end
            else
                if (I(1)==I(2))
                    value = I(1);
                    if (value > 0.1)
                        high=I(1);
                        middle = I(2);
                        small=I(3);
                        column_correspondence(p,q)=((middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        middle=I(2);
                        high=I(3);
                        column_correspondence(p,q)=(3+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                if (I(2)==I(3))
                    value = I(2);
                    if (value >0.1)
                        small=I(1);
                         middle =I(2);
                        high=I(3);
                        column_correspondence(p,q)=(4+(middle-small)/(high-small))*(1920/6);
                    else
                        high=I(1);
                        middle=I(2);
                        small=I(3);
                        column_correspondence(p,q) = (1+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                if (I(1)==I(3))
                    value = I(3);
                    if (value >0.1)
                        high=I(1);
                        small=I(2);
                        middle=I(3);
                        column_correspondence(p,q) = (2+(middle-small)/(high-small))*(1920/6);
                    else
                        small=I(1);
                        high=I(2);
                        middle=I(3);
                        column_correspondence(p,q) = (5+1-(middle-small)/(high-small))*(1920/6);
                    end
                end
                %column_correspondence(p,q)=0;
            end
        else
            column_correspondence(p,q)=0;
        end
    end
end
phi=(2*pi*column_correspondence)/1920;

%Ground truth Images  (Number of images=30)
startp=2158;
endp=startp+29;
I0 = imread('IMG_2068.tiff');
sumImage = rgb2gray(im2double(I0));
for i = startp:endp
nameID = num2str(i);
s = strcat('IMG_', nameID, '.tiff');
index = i - startp + 1;
rgbimage = rgb2gray(im2double(imread(s))); sumImage =sumImage+rgbimage;
end
meanImage = sumImage / 30;

%Root Mean Square Error
phi(isnan(phi))=0;
phi_ground(isnan(phi_ground))=0;
errorsine=sqrt(mean2((phi - phi_ground).^2));

%Absolute error
errorsine=mean2(abs(phi_sine_test(957:3086,298:4292) - phi_sine_ground(957:3086,298:4292)));
errorcube=mean2(abs(phi_cube_test(957:3086,298:4292) - phi_sine_ground(957:3086,298:4292)));
errortri=mean2(abs(phi_tri_test(957:3086,298:4292) - phi_sine_ground(957:3086,298:4292)));
errorsaw=mean2(abs(phi_saw_nomax_test(957:3086,298:4292) - phi_sine_ground(957:3086,298:4292)));