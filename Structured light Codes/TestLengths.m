
clear all; clc
 
% IS1 = im2double(imread('Sine1.tiff'));
% IS2 = im2double(imread('Sine2.tiff'));
% IS3 = im2double(imread('Sine3.tiff'));
% figure;plot([1:1920], IS1(1,:), 'r-', [1:1920], IS2(1,:), 'g-', [1:1920], IS3(1,:), 'b-', 'LineWidth', 3)
% 
% IT1 = im2double(imread('Tri1.tiff'));
% IT2 = im2double(imread('Tri2.tiff'));
% IT3 = im2double(imread('Tri3.tiff'));
% figure;plot([1:1920], IT1(1,:), 'r-', [1:1920], IT2(1,:), 'g-', [1:1920], IT3(1,:), 'b-', 'LineWidth', 3)

% IS1Plot = IS1(1,:);
% IS2Plot = IS2(1,:);
% IS3Plot = IS3(1,:);
% IT1Plot = IT1(1,:);
% IT2Plot = IT2(1,:);
% IT3Plot = IT3(1,:);

N           = 10000;
X           = [1:N];
IS1Plot     = 0.5 + 0.5*cos(2*pi*X/N);
 IS2Plot     = 0.5 + 0.5*cos(2*pi*X/N + 2*pi/3);
 IS3Plot     = 0.5 + 0.5*cos(2*pi*X/N + 4*pi/3);
 IS2Plot     = 0.5 + 0.5*cos(2*pi*X/N + pi/2);
IS3Plot     = 0.5 + 0.5*cos(2*pi*X/N + 3*pi/4);

figure;plot([1:N], IS1Plot, 'r-', [1:N], IS2Plot, 'g-', [1:N], IS3Plot, 'b-', 'LineWidth', 3)
IS1Shift    = circshift(IS1Plot, [0 1]);
IS2Shift    = circshift(IS2Plot, [0 1]);
IS3Shift    = circshift(IS3Plot, [0 1]);

SinDistances    = sqrt((IS1Plot - IS1Shift).^2 + (IS2Plot - IS2Shift).^2 + (IS3Plot - IS3Shift).^2);
figure;plot(SinDistances)
sum(SinDistances(:))

% IT1Plot     = (asin(sin(2*pi*X/N)) + pi/2)/pi;
% IT2Plot     = (asin(sin(2*pi*X/N + 2*pi/3))+ pi/2)/pi;
% IT3Plot     = (asin(sin(2*pi*X/N + 4*pi/3))+ pi/2)/pi;
IT1Plot     = 0.5 + 0.5*sawtooth(2*pi*X/N);
IT2Plot     = 0.5 + 0.5*sawtooth(2*pi*X/N + 2*pi/3);
IT3Plot     = 0.5 + 0.5*sawtooth(2*pi*X/N + 4*pi/3);
figure;plot([1:N], IT1Plot, 'r-', [1:N], IT2Plot, 'g-', [1:N], IT3Plot, 'b-', 'LineWidth', 3)
IT1Shift    = circshift(IT1Plot, [0 1]);
IT2Shift    = circshift(IT2Plot, [0 1]);
IT3Shift    = circshift(IT3Plot, [0 1]);
TriDistances    = sqrt((IT1Plot - IT1Shift).^2 + (IT2Plot - IT2Shift).^2 + (IT3Plot - IT3Shift).^2);
figure;plot(TriDistances)
sum(TriDistances(:))
