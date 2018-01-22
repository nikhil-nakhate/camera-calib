

%%% IMPORTANT: Points have to be clicked clockwise starting from top-left, 
%%% for every prompt. Every time you are asked to click four grid corners. 


% clear all; clc; close all; pack


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Base Dirname %%%%%%%%%%%%%%%%%%%%%%%%
basedirname     = ['C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric'];
%addpath('Z:\Columbia\Micro Phase Shifting\Code\CalibrationAndReconstruction\Geometric\lib\mlStructuredLight\mlStructuredLight'); % Add required subdirectories.
ImSuffix        = 'tif';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nxProj          = 1920;                           	% number of projector columns
nyProj          = 1080;                             % number of projector rows

% Select projector calibation images for inclusion.
useProjImages   = [1:16];

% Define projector calibration plane properties.
% Note: These lengths are used to determine the extrinsic calibration.
%       That is, the transformation(s) from reference plane(s) -> camera.
proj_cal_nX = 1;         % number of rectangles along x-axis
proj_cal_nY = 1;         % number of rectangles along y-axis
proj_cal_dX = 192;       % length along x-axis (mm) (between checkerboard rectangles) 
proj_cal_dY = 192;       % length along y-axis (mm) (between checkerboard rectangles) 


%%%%%%%%%%%%% Synthesize projected image. Just paste the code for the
%%%%%%%%%%%%% projected image here. 

I       = zeros(1080, 1920);
IS      = [ones(64,64) zeros(64,64); zeros(64,64) ones(64,64)];
IS      = repmat(IS, [5 5]);
I(101:740, 101:740) = IS;
I       = repmat(I, [1 1 3]);
I       = im2uint8(I);

%%% Indices of the projected checkerboard grid. I clicked by leaving
%%% outermost corner, so I accounted for that in specifying
%%% the indices. 
x   = [164:64:676]    - 0.5;
y   = [164:64:676]    - 0.5;

[X,Y] = meshgrid(x,y);

%%%% Some manipulation needed on X and Y due to some convention in the
%%%% camera-calibration tool-box. I haven't figured out the convention too
%%%% well - so this manipulation will be on a case to case basis. 

X   = fliplr(X);
Y   = fliplr(Y);


%X   = fliplr(X);
%Y   = Y;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% Loading only the variables that are needed fom camera calibration
load([basedirname, '\cam\Calib_Results.mat'], 'fc', 'cc', 'kc', 'alpha_c', 'Rc_1', 'Tc_1', 'x_1', 'X_1', 'nx', 'ny', 'n_sq_x_1', 'n_sq_y_1', 'dX', 'dY');

% Save the camera calibration results (in "side" variables).
fc_cam       = fc;
cc_cam       = cc;
kc_cam       = kc;
alpha_c_cam  = alpha_c;
Rc_1_cam     = Rc_1;
Tc_1_cam     = Tc_1;
x_1_cam      = x_1;
X_1_cam      = X_1;
nx_cam       = nx;
ny_cam       = ny;
n_sq_x_1_cam = n_sq_x_1;
n_sq_y_1_cam = n_sq_y_1;
dX_cam       = dX;
dY_cam       = dY;


%%%% Remove the variables which have been renamed and stored as they might
%%%% interfere with later variable loads. 
clear('fc', 'cc', 'kc', 'alpha_c', 'Rc_1', 'Tc_1', 'x_1', 'X_1', 'nx', 'ny', 'n_sq_x_1', 'n_sq_y_1', 'dX', 'dY');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% Computing the transformations from the projector calibration planes to
%%% the camera
%%% Number of projected images
%load([basedirname, '\proj\calib_data.mat'], 'n_ima')
% SET THIS
n_ima = 16;
start_idx = 5858;

if ~exist([basedirname, '\proj\ext_calib_data.mat'], 'file')
   for i = 1:n_ima
       frame = [basedirname, '\proj\IMG_', num2str(start_idx + i)];
       [Tc,Rc,H] = computeExtrinsic(fc_cam, cc_cam, kc_cam, alpha_c_cam, frame, ImSuffix, proj_cal_nX, proj_cal_nY, proj_cal_dX, proj_cal_dY);
       eval(['Rc_',int2str(i),' = Rc']);
       eval(['Tc_',int2str(i),' = Tc']);
       if i == 1
           save([basedirname, '\proj\ext_calib_data.mat'],['Rc_',int2str(i)]);
       else
           save([basedirname, '\proj\ext_calib_data.mat'],['Rc_',int2str(i)],'-append');
       end
       save([basedirname, '\proj\ext_calib_data.mat'],['Tc_',int2str(i)],'-append');
   end
else
   load([basedirname, '\proj\ext_calib_data.mat']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load all projected checkerboard corners for projector calibration images.
% Note: Calibrate reference plane positions (if not available).

%%
for i = 1:n_ima
    load([basedirname, '\proj\calib_data.mat'], ['x_', num2str(i)]);
    eval(['xproj_',int2str(i),' = x_',int2str(i),';']);
    clear(['x_', num2str(i)]);          %%% Remove the renamed variable so that it doesn't interfere with later variables
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%

for i = 1:n_ima
   eval(['x_proj_',int2str(i),' = [X(:) Y(:)]'';']);
end

clear X Y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%% Display the first projector calibration image.
I_proj1 = imread([basedirname, '\proj\IMG_5859.', ImSuffix]);
figure(2); image(I_proj1);
hold on;
   plot(xproj_1(1,:)+1,xproj_1(2,:)+1,'r+');
hold off;
title(['First projector calibration image:Frame1.', ImSuffix]);
drawnow;

% Display points on projector image.
figure(3); image(I); colormap(gray);
hold on;
   plot(x_proj_1(1,:)+1,x_proj_1(2,:)+1,'r.');
hold off;
title('Points overlaid on projector image');
drawnow;

% Display the 3D configuration using the extrinsic calibration.
% X_proj     = []; % 3D coordinates of the points
% x_proj     = []; % 2D coordinates of the points in the projector image
% n_ima_proj = []; % number of calibration images

%I corrected this, Rc_i from cam has to be used use loadRcTc to interchange the Rc_i Tc_i -Nikhil
for i = 1:n_ima
   
   % Transform calibation marker positions to camera coordinate system.
   X = [0 192 192 0; 0 0 192 192; 0 0 0 0]; %2D in proj ref frame
   temp_here = ['Rc_',int2str(i),'*X + repmat(Tc_',int2str(i),',1,size(X,2));']; %2D in cam ref frame

   X = eval(temp_here);
   
   % Recover 3D points corresponding to projector calibration pattern.
   % Note: Uses ray-plane intersection to solve for positions.
   V = eval(['pixel2ray(xproj_',int2str(i),',fc_cam,cc_cam,kc_cam,alpha_c_cam);']); %vector 
   C = zeros(3,size(V,2));
   calPlane = fitPlane(X(1,:),X(2,:),X(3,:));
   X = intersectLineWithPlane(C,V,calPlane');
   
   % Concatenate projector and world correspondances.
%    eval(['xproj = xproj_',num2str(i),';']);               %%%% Remove
   eval(['X_proj_',num2str(i),' = X;']);
%    eval(['X_proj = [X_proj X_proj_',num2str(i),'];']);    %%%% Remove
%    eval(['x_proj = [x_proj x_proj_',num2str(i),'];']);    %%%% Remove
%    n_ima_proj = [n_ima_proj i*ones(1,size(V, 2))];

   clear C V X
end


% Configure the projector model (must be done before calibration).
nx           = nxProj;                            % number of projector columns
ny           = nyProj;                             % number of projector rows
no_image     = 1;                               % only use pre-determined corners
n_ima        = numel(useProjImages);            % default behavior for a single image
est_dist     = [1;1;0;0;0];                     % select distortion model
est_alpha    = 0;                               % no skew
center_optim = 1;                               % estimate the principal point

% Run the main projector calibration routine.
for i=1:numel(useProjImages)
   eval(['X_',num2str(i),' = X_proj_', num2str(useProjImages(i)), ';']); 
   eval(['x_',num2str(i),' = x_proj_', num2str(useProjImages(i)), ';']);
end

check_cond=0;

go_calib_optim; %This doesn't work very well. Required to estimate radial
%distortion

% Save the projector calibration results as projector_results.mat.
dX  = 33;    %% Just random numbers for scaling in display. Not useful anywhere else
dY  = 33;

for i=1:n_ima
   load([basedirname, '\proj\calib_data.mat'], ['n_sq_x_', num2str(i)], ['n_sq_y_', num2str(i)]);
end

%Manually setting these for now; Too much going on!!
for i=1:n_ima
   eval(['n_sq_x_', num2str(i) '= 8;']);
   eval(['n_sq_y_', num2str(i) '= 8;']);
end

saving_calib; 

mkdir([basedirname, '\results']);
copyfile('Calib_Results.mat', [basedirname, '\results\projector_results.mat']);
delete('Calib_Results.mat'); delete('Calib_Results.m');

% Save the projector calibration results (in "side" variables).
fc_proj       = fc_current;
cc_proj       = cc_current;
kc_proj       = kc_current;
alpha_c_proj  = alpha_c;
Rc_1_proj     = Rc_1;
Tc_1_proj     = Tc_1;
x_1_proj      = eval(['x_proj_',num2str(useProjImages(1)),';']);
X_1_proj      = eval(['X_proj_',num2str(useProjImages(1)),';']);
nx_proj       = nx;
ny_proj       = ny;
n_sq_x_1_proj = 8;
n_sq_y_1_proj = 8;
dX_proj       = dX;
dY_proj       = dY;

%eval(['n_sq_x_',num2str(useProjImages(1)),';'])
%eval(['n_sq_y_',num2str(useProjImages(1)),';'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part IV: Display calibration results.

% Plot camera calibration results (in camera coordinate system).
procamCalibDisplay;

hold on;
Y     = Rc_1_cam*X_1_cam + Tc_1_cam*ones(1,size(X_1_cam,2));
Yx    = zeros(n_sq_x_1_cam+1,n_sq_y_1_cam+1);
Yy    = zeros(n_sq_x_1_cam+1,n_sq_y_1_cam+1);
Yz    = zeros(n_sq_x_1_cam+1,n_sq_y_1_cam+1);
Yx(:) = Y(1,:); Yy(:) = Y(2,:); Yz(:) = Y(3,:);
mesh(Yx,Yz,-Yy,'EdgeColor','r','LineWidth',1);
Y     = X_proj_1;
Yx    = zeros(n_sq_x_1_proj+1,n_sq_y_1_proj+1);
Yy    = zeros(n_sq_x_1_proj+1,n_sq_y_1_proj+1);
Yz    = zeros(n_sq_x_1_proj+1,n_sq_y_1_proj+1);
Yx(:) = Y(1,:); Yy(:) = Y(2,:); Yz(:) = Y(3,:);
mesh(Yx,Yz,-Yy,'EdgeColor','g','LineWidth',1);

hold off;

title('Projector/Camera Calibration Results');
xlabel('X_c'); ylabel('Z_c'); zlabel('Y_c');
view(50,20); grid on; rotate3d on;
axis equal tight vis3d; drawnow;


%% Old & Gold Save Results


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part V: Save calibration results.

% Determine mapping from projector pixels to optical rays.
% Note: Ideally, the projected images should be pre-warped to
%       ensure that projected planes are actually planar.
c = 1:nx_proj;
r = 1:ny_proj;
[C,R] = meshgrid(c,r);
np  = pixel2ray([C(:) R(:)]',fc_proj,cc_proj,kc_proj,alpha_c_proj);
np = Rc_1_proj'*(np - Tc_1_proj*ones(1,size(np,2)));
Np = zeros([ny_proj nx_proj 3]);
Np(:,:,1) = reshape(np(1,:),ny_proj,nx_proj);
Np(:,:,2) = reshape(np(2,:),ny_proj,nx_proj);
Np(:,:,3) = reshape(np(3,:),ny_proj,nx_proj);
P = -Rc_1_proj'*Tc_1_proj;

% Estimate plane equations describing every projector column.
% Note: Resulting coefficient vector is in camera coordinates.
wPlaneCol = zeros(nx_proj,4);
for i = 1:nx_proj
   wPlaneCol(i,:) = ...
      fitPlane([P(1); Np(:,i,1)],[P(2); Np(:,i,2)],[P(3); Np(:,i,3)]);
   %figure(4); hold on;
   %plot3(Np(:,i,1),Np(:,i,3),-Np(:,i,2),'r-');
   %drawnow;
end

% Estimate plane equations describing every projector row.
% Note: Resulting coefficient vector is in camera coordinates.
wPlaneRow = zeros(ny_proj,4);
for i = 1:ny_proj
   wPlaneRow(i,:) = ...
      fitPlane([P(1) Np(i,:,1)],[P(2) Np(i,:,2)],[P(3) Np(i,:,3)]);
   %figure(4); hold on;
   %plot3(Np(i,:,1),Np(i,:,3),-Np(i,:,2),'g-');
   %drawnow;
end

% Pre-compute optical rays for each camera pixel.


c    = 1:nx_cam;
r    = 1:ny_cam;
[C,R] = meshgrid(c,r);
Nc   = Rc_1_cam*Rc_1_cam'*pixel2ray([C(:) R(:)]'-1,fc_cam,cc_cam,kc_cam,alpha_c_cam);
Oc   = Rc_1_cam*Rc_1_cam'*(-Tc_1_cam) + Tc_1_cam;

% Save the projector/camera calibration results as calib_cam_proj.mat.
save_command = ...
   ['save ./calib_cam_proj ',...
    'fc_cam cc_cam kc_cam alpha_c_cam Rc_1_cam Tc_1_cam ',...
    'x_1_cam X_1_cam nx_cam ny_cam n_sq_x_1_cam n_sq_y_1_cam ',...
    'dX_cam dY_cam ',...
    'fc_proj cc_proj kc_proj alpha_c_proj Rc_1_proj Tc_1_proj ',...
    'x_1_proj X_1_proj nx_proj ny_proj n_sq_x_1_proj n_sq_y_1_proj '...
    'dX_proj dY_proj '...
    'Oc Nc wPlaneCol wPlaneRow'];
eval(save_command);

mkdir([basedirname, '\results']);
movefile('calib_cam_proj.mat', [basedirname, '\results\calib_cam_proj.mat']);



%% Wrong
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part V: Save calibration results.

% Determine mapping from projector pixels to optical rays.
% Note: Ideally, the projected images should be pre-warped to
%       ensure that projected planes are actually planar.


c = 1:nx_proj;
r = 1:ny_proj;
[C,R] = meshgrid(c,r);

np  = pixel2ray([C(:) R(:)]',fc_proj,cc_proj,kc_proj,alpha_c_proj);
%np = Rc_1_proj'*(np - Tc_1_proj*ones(1,size(np,2)));

P = -Rc_1_proj'*Tc_1_proj;


   %V = eval(['pixel2ray(xproj_',int2str(i),',fc_cam,cc_cam,kc_cam,alpha_c_cam);']); %vector 
   %C = zeros(3,size(np,2));
   Xnew = [C(:), R(:), zeros(size(C(:)))];
   Xnew = Xnew';
   temp_here = ['Rc_',int2str(1),'_cam*Xnew + repmat(Tc_',int2str(1),'_cam,1,size(Xnew,2));']; %2D in cam ref frame

   Xnew = eval(temp_here);
calPlane = fitPlane(Xnew(1, :), Xnew(2, :), Xnew(3, :));
np = intersectLineWithPlane(repmat(P,1,2073600) ,np,calPlane');
Np = zeros([ny_proj nx_proj 3]);
Np(:,:,1) = reshape(np(1,:),ny_proj,nx_proj);
Np(:,:,2) = reshape(np(2,:),ny_proj,nx_proj);
Np(:,:,3) = reshape(np(3,:),ny_proj,nx_proj);




% Estimate plane equations describing every projector column.
% Note: Resulting coefficient vector is in camera coordinates.
wPlaneCol = zeros(nx_proj,4);
for i = 1:nx_proj
   wPlaneCol(i,:) = ...
      fitPlane([P(1); Np(:,i,1)],[P(2); Np(:,i,2)],[P(3); Np(:,i,3)]);
   %figure(4); hold on;
   %plot3(Np(:,i,1),Np(:,i,3),-Np(:,i,2),'r-');
   %drawnow;
end

% Estimate plane equations describing every projector row.
% Note: Resulting coefficient vector is in camera coordinates.
wPlaneRow = zeros(ny_proj,4);
for i = 1:ny_proj
   wPlaneRow(i,:) = ...
      fitPlane([P(1) Np(i,:,1)],[P(2) Np(i,:,2)],[P(3) Np(i,:,3)]);
   %figure(4); hold on;
   %plot3(Np(i,:,1),Np(i,:,3),-Np(i,:,2),'g-');
   %drawnow;
end

% Pre-compute optical rays for each camera pixel.


c    = 1:nx_cam;
r    = 1:ny_cam;
[C,R] = meshgrid(c,r);
Nc   = Rc_1_cam*Rc_1_cam'*pixel2ray([C(:) R(:)]',fc_cam,cc_cam,kc_cam,alpha_c_cam);
Oc   = Rc_1_cam*Rc_1_cam'*(-Tc_1_cam) + Tc_1_cam;

% Save the projector/camera calibration results as calib_cam_proj.mat.
save_command = ...
   ['save ./calib_cam_proj ',...
    'fc_cam cc_cam kc_cam alpha_c_cam Rc_1_cam Tc_1_cam ',...
    'x_1_cam X_1_cam nx_cam ny_cam n_sq_x_1_cam n_sq_y_1_cam ',...
    'dX_cam dY_cam ',...
    'fc_proj cc_proj kc_proj alpha_c_proj Rc_1_proj Tc_1_proj ',...
    'x_1_proj X_1_proj nx_proj ny_proj n_sq_x_1_proj n_sq_y_1_proj '...
    'dX_proj dY_proj '...
    'Oc Nc wPlaneCol wPlaneRow'];
eval(save_command);

mkdir([basedirname, '\results']);
movefile('calib_cam_proj.mat', [basedirname, '\results\calib_cam_proj.mat']);