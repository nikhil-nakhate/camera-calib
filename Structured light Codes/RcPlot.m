
% Convert Images to tiff
file_arr = dir('*.CR2');    
for i=1:numel(file_arr)

    dos(['dcraw -v -4 -q 3 -T ', file_arr(i).name]);

end
%%

indices = 3180:3435;
arr = zeros(256,1);

% patch top left and bottom right
pRstart = 2111;
pRend = 2131;
pCstart = 2490;
pCend = 2510;

% Image with nothing projeced
img_name = sprintf('IMG_3167.tiff');
PRc2 = im2double(rgb2gray(imread(img_name)));
patch2 = PRc2(pRstart:pRend,pCstart:pCend);
p_mean2 = mean(patch2(:));


for i=1:numel(indices)
    img_name = sprintf('IMG_%04d.tiff',indices(i))
    PRc = im2double(rgb2gray(imread(img_name)));
    patch = PRc(pRstart:pRend,pCstart:pCend);
    p_mean = mean(patch(:));
    arr(i) = p_mean;
end

% Subtracting the mean of the image with nothing projected
arr = arr - p_mean2;

keyboard
%%

ip = double(0:255) / 255;
ip = ip';
y = arr;
poly = polyfit(ip,y,8);
op = polyval(poly,ip);
plot(ip,op);
saveas(gcf, 'rcplot.fig');

% set these values after 
cStart = 88;
cEnd = 242;

ip = ip(cStart:cEnd);
op = op(cStart:cEnds);


%%

file_arr = dir('*.tiff');
for i=1:numel(file_arr)
    P{i} = im2double(imread(file_arr(i).name));
    P{i} = P{i} * 0.9 + .05;
end

%%
% init params
P16 = {};
N = size(P,2);
type = 'Sine';
% type = 'Hamilt';


for i = 1:N
    % P{i} = interp1(op, ip, P{i}, 'pchip');
    P16{i} = im2uint16(P{i});
    imwrite(P16{i}, sprintf('%s%d_%02d.tiff',type, N, i));
end


%% 
% Different intensity levels

P16 = {};
file_arr = dir('*.tiff');

% Set this
% type = 'Hamilt';
type = 'Sine';


multiplier = [0.1 0.2 0.3 0.45 0.6 1];
N = numel(file_arr);
for i=1:N
    for m = multiplier
        P{i} = im2double(imread(file_arr(i).name));
        P{i} = P{i} * m;
        P{i} = interp1(op, ip, P{i}, 'pchip');
        P16{i} = im2uint16(P{i});
        imwrite(P16{i}, sprintf('%s%d_%03d_%02d.tiff', type, N, round(m * 100), i));
    end
end

%%

% x2 = x * 142 / 255;
% x2 = x2 + 89;
% y2 = interp1(x1, y1, x2);
% 
% %inverse function; This would take the the values that we have and map it to what need to be projected
% x3 = interp1(y2, x2, (double(0:255) * 230 / 255) + 10, 'pchip'); 
% %y = double(y / 256.);

%%
% plot(x,y);
% hold on;
% plot(x,y1)
% x2 = x * 235 / 255;
% x2 = x2 + 5;
% y2 = interp1(x,y1,x2,'pchip');
% x3 = interp1(y2,x2,0:255);
% hold off;
% plot(y2)
% plot(x3)
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