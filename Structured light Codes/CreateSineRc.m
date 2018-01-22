N = 3;
m = 1080;
n = 1920;

N=3;
for a = 1:N
    for xl = 1:n
        p(1:m,xl) = 0.5+ ones(m,1) * cos(2*pi*xl/n + 2*pi*(a-1)/N)*0.5;
    end
    P{a} = p  * 0.9 + .05;
end

%% Not using this stuff currently - 12/31
x = ((0:255)/255);

for num=1:N
for ii=1:size(P{num},1)
for jj=1:size(P{num},2)
y = abs(P{num}(ii,jj)-x);
a = (find(y == min(y))-1);
%diff(ii,jj)=a(1);
%disp(value(a(1)+1)/255)
corrected_gray(ii,jj)=x3(a(1)+1)/255; %Radiometric cali applied using grayscale

%corrected_rgb(ii,jj,1)=(valueR(a(1)+1)/255);
%corrected_rgb(ii,jj,2)=(valueG(a(1)+1)/255);
%corrected_rgb(ii,jj,3)=(valueB(a(1)+1)/255); %Radimetric cali applied using R,G,B.
end
end
Pc{num}=im2uint16(corrected_gray);
imwrite(Pc{num}, sprintf('Sine_%d_%d.tiff',N,num));
end
