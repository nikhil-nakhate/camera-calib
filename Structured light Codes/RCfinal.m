
figure;plot(arr(62:232))
arrTrunc = arr(62:232);
indices = [62:232];

ip = indices / 255;

poly = polyfit(ip, arrTrunc', 4);
op  = polyval(poly, ip);
figure;plot(ip, op)
hold
plot(ip, arrTrunc, 'r-')

hamiltCode = im2double(imread('C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric\Sine5\Sine5_01.tiff'));
hamiltCode = hamiltCode(1, :);
figure;plot(hamiltCode)

hamiltInterp = interp1(op, ip, hamiltCode, 'pchip');
figure;plot(hamiltInterp)

%% Have used only twice not needed again. 1/12/18
P16 = {};
P = {};
file_arr = dir('*.tiff');

% Set this
% type = 'Hamilt';
type = 'Sine';

N = numel(file_arr);
for j = 1:N
    P{j} = im2double(imread(file_arr(j).name));
    P{j} = (P{j} - 0.05) / 0.9;
    P16{j} = im2uint16(P{j});
    imwrite(P16{j}, sprintf('%s%d_%02d.tiff',type, N, j));
end
%% SET TYPE BEFORE RUNNING THIS SECTION
P16 = {};
P = {};
file_arr = dir('*.tiff');

% SET THIS
% type = 'Hamilt';
type = 'Hilbert';

multiplier = [0.1 0.2 0.3 0.45 0.6 1];
N = numel(file_arr);
for i=1:N
    for m = multiplier
        P{i} = im2double(imread(file_arr(i).name));
        P{i} = P{i} * m;
        P{i} = P{i} * (0.88 - 0.01) + 0.01;
        P{i} = interp1(op, ip, P{i}, 'pchip');
        P16{i} = im2uint16(P{i});
        imwrite(P16{i}, sprintf('%s%d_%03d_%02d.tiff', type, N, round(m * 100), i));
    end
end

