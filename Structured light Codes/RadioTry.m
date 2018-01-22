% N= 3;
% m = 1080;
% n = 1920;
% 
% for a = 1:N
%     for xl = 1:n
%         p(1:m,xl) = 0.5+ ones(m,1) * cos(2*pi*xl/n + 2*pi*(a-1)/N)*0.5;
%     end
%     P{a} = p;
% end

N = 5;
m = 1080;
n = 1920;

for a = 1:N
    file_name = sprintf('Pattern0%d.tiff',a);
    P{a} = im2double(imread(file_name));
end

%%
x = ((0:255)/255);

for num=1:N
for ii=1:size(P{num},1)
for jj=1:size(P{num},2)
y = abs(P{num}(ii,jj)-x);
a = (find(y == min(y))-1)
%diff(ii,jj)=a(1);
%disp(value(a(1)+1)/255)
corrected_gray(ii,jj)=x3(a(1)+1)/255; %Radiometric cali applied using grayscale

%corrected_rgb(ii,jj,1)=(valueR(a(1)+1)/255);
%corrected_rgb(ii,jj,2)=(valueG(a(1)+1)/255);
%corrected_rgb(ii,jj,3)=(valueB(a(1)+1)/255); %Radimetric cali applied using R,G,B.
end
end
Pc{num}=im2uint16(corrected_gray);
end
%%
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