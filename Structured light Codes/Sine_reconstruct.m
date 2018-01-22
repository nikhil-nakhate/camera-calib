
k = dir('E:\6X6 Images Proj1 Min\EP_4 and EP_5 images\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname=k(i).name;
    Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

for pic=1:30
%ind=(3*pic)+1;
%Phase map for sine
%Image{1}=im2double(imread('Image1.tiff'));
%Image{2}=im2double(imread('Image2.tiff'));
%Image{3}=im2double(imread('Image3.tiff'));
Image{1}= Test{pic};
Image{2}= Test{30+pic};
Image{3}= Test{60+pic};
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
correspondence_sine1{pic}=phi;
end

for pic=1:30
%ind=(3*pic)+1;
%Phase map for sine
%Image{1}=im2double(imread('Image1.tiff'));
%Image{2}=im2double(imread('Image2.tiff'));
%Image{3}=im2double(imread('Image3.tiff'));
Image{1}= Test{pic+90};
Image{2}= Test{30+pic+90};
Image{3}= Test{60+pic+90};
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
correspondence_sine2{pic}=phi;
end
for pic=1:30
%ind=(3*pic)+1;
%Phase map for sine
%Image{1}=im2double(imread('Image1.tiff'));
%Image{2}=im2double(imread('Image2.tiff'));
%Image{3}=im2double(imread('Image3.tiff'));
Image{1}= Test{pic+180};
Image{2}= Test{30+pic+180};
Image{3}= Test{60+pic+180};
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
correspondence_sine3{pic}=phi;
end
for pic=1:30
%ind=(3*pic)+1;
%Phase map for sine
%Image{1}=im2double(imread('Image1.tiff'));
%Image{2}=im2double(imread('Image2.tiff'));
%Image{3}=im2double(imread('Image3.tiff'));
Image{1}= Test{pic+270};
Image{2}= Test{30+pic+270};
Image{3}= Test{60+pic+270};
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
correspondence_sine4{pic}=phi;
end
%save('Sine.mat','correspondence_sine','-v7.3');

for pic=0
ind=(3*pic)+1;
%Phase map for sine
Image{1}=im2double(imread('Image1.tiff'));
Image{2}=im2double(imread('Image2.tiff'));
Image{3}=im2double(imread('Image3.tiff'));
%Image{1}= Test{ind};
%Image{2}= Test{ind+1};
%Image{3}= Test{ind+2};
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
correspondence_ground_truth{pic+1}=phi;
end
save('Ground_truth.mat','correspondence_ground_truth','-v7.3');
