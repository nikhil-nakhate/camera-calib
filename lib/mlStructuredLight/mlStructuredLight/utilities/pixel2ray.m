function v = pixel2ray(x,fc,cc,kc,alpha_c)

% PIXEL2RAY  
%    V = PIXEL2RAY(X,FC,CC,KC,ALPHA_C) determines the ray V originating
%    from the camera and passing through a given pixel X. This function
%    assumes that the intrinsic parameters {FC,CC,KC,ALPHA_C} were
%    previously computed using the Matlab Calibration Toolbox.
%
% Douglas Lanman and Gabriel Taubin 
% Brown University
% 18 May 2009

% Converts a pixel (in image coords.) to a ray (in the camera coords.).
v  = normalize(x,fc,cc,kc,alpha_c);
v  = [v; ones(1,size(v,2))]; %homogenous co-ordinates
v  = v./repmat(sqrt(sum(v.^2,1)),3,1); %dividing by magnitute for unit ray