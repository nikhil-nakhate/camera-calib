function [errTbl]     = CalibrationTest(indx, GT, SL)

% parameters
limVec      = [1000, 3000, 600, 3700];
minV        = -20;
maxV        = 3200;
scale       = 500;
offset      = 500;

% ground truth 
load(GT);
colGT      	= Depths{1};

% sin, high-noise
load(SL)
colSin    	= correspondence_sine3{1, indx};

% hamilt, high-noise
%load('C:\Users\mohitg-admin\Dropbox\ColumbiaDesktopEdits\D-Drive\Current\Projects\SLWithOptimalSNR\Experiments\2016-11-06\Hamilt03_Highnoise.mat')
%colHamilt 	= Column_highnoise;


for i=1:limVec(2)-limVec(1)+1
    fitObj  = fit([limVec(3):limVec(4)]'-limVec(3)+1, colGT(i-1+limVec(1),limVec(3):limVec(4))', 'poly2');

    a           = sqrt(-fitObj.p1);
    b           = fitObj.p2 / (2*a);
    c           = -b^2 - fitObj.p3;

    DepthsGT(i,:)       = TransformCorrToDist(colGT, [i-1+limVec(1) i-1+limVec(1) limVec(3) limVec(4)], a, b, c, minV, maxV, scale, offset);
    DepthsSin(i,:)    	= TransformCorrToDist(colSin, [i-1+limVec(1) i-1+limVec(1) limVec(3) limVec(4)], a, b, c, minV, maxV, scale, offset);
 %   DepthsHamilt(i,:) 	= TransformCorrToDist(colHamilt, [i-1+limVec(1) i-1+limVec(1) limVec(3) limVec(4)], a, b, c, minV, maxV, scale, offset);

end

figure;surf(DepthsSin(1:10:end, 1:10:end));
%figure;surf(DepthsHamilt(1:10:end, 1:10:end));

ErrSin   	= DepthsSin-DepthsGT;
figure;surf(ErrSin(10:10:end, 20:10:end))
errTbl = vpa(mean(abs(ErrSin(:))));

%ErrHamilt  	= DepthsHamilt-DepthsGT;
%figure;surf(ErrHamilt(1:10:end, 1:10:end))
%mean(abs(ErrHamilt(:)))