%% SET THIS
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric\Publishable\Captured\Sine4\';
files = dir([dirname, '*.tiff']);
filenames = {files.name}';

isRGB = 1;
clear help ind pic;

% This is 1 for GT usually 36
total_cond = 36;
correspondence_sine4 = {};
corr_name = 'correspondence_sine4';
Image = {};
Test = {};
for i=1:numel(filenames)
    %fname = ['IMG_', sprintf('%04d', indices(i)), '.CR2']
    % fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname = filenames{i}
    if(isRGB)
        Test{i} = rgb2gray(im2double(imread(fname)));
    else
        Test{i} = im2double(imread(fname));
    end
    %
    %Test{i}=imread(fname);
    %expVal = FindExposure(fname)
    %imwrite
end

%%
for pic=0:total_cond - 1
ind=(4*pic)+1
% Image{1}= Test{pic};
% Image{2}= Test{30+pic};
% Image{3}= Test{60+pic};
% % Image{4}= Test{60+pic};

Image{1}= Test{ind};
Image{2}= Test{ind+1};
Image{3}= Test{ind+2};
Image{4}= Test{ind+3};
m=size(Image{1},1);
n=size(Image{1},2);
N = 4;
help(:,:,1)=Image{1};
help(:,:,2)=Image{2};
help(:,:,3)=Image{3};
help(:,:,4)=Image{4};
for i = 1:N
            M(i,:) = [1 cos(2*pi*(i-1)/N) -sin(2*pi*(i-1)/N)];
end
M=pinv(M);
x=reshape(help,(m*n),4);
X=M*x';
v=X(3,:);
b=find(v>=0);
a=find(v<0);
X(3,b)=acos(X(2,b)./sqrt(X(2,b).^2 + X(3,b).^2));
X(3,a)=2*pi-acos(X(2,a)./sqrt(X(2,a).^2 + X(3,a).^2));
phi_p=X(3,:);
phi=reshape(phi_p,m,n);
correspondence_sine4{pic+1}=phi;
correspondence_sine4{pic+1}=correspondence_sine4{pic+1}*1920/(2*pi);
[m1, n1] = size(correspondence_sine4{pic+1}(2500, :));
fig = plot(1:n1, correspondence_sine4{pic+1}(2500, :));
fname1 = ['Sine4', sprintf('%04d', pic), '.png'];
saveas(fig,fname1);
clear M
end
corr_path = [dirname, sprintf('%s.mat', corr_name)];
save(corr_path, corr_name , '-v7.3');
clear help ind pic;