function[vertices_subset, Depths_Subset] = slReconstruct(corr_index, corr, sub_folder_name, rep_image_name)

% pack; clc; close all

% slReconstruct reconstructs 3D from captured structured light system. 

basedirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
% Load calibration data.
load([basedirname, '\results\calib_cam_proj.mat']);

% Input Data Parameters.
dataDirname             = [basedirname, sub_folder_name];
dSampleProj             = 1;        %% downsampling factor (i.e., min. system resolution)
HVFlag                  = 1;        %% 1 if you are using columns to reconstruct, 2 if using rows. 
imSuffix                = ['.tiff'];


% Set reconstruction parameters.
dSamplePlot     = 1;        % down-sampling rate for all operations
scatterSample   = 10;       % down-sampling rate for Matlab point cloud display
distReject      = inf;      % rejection distance (for outlier removal)

% Other parameters
nCam            = 1;        %% Number of cameras
projDim         = [1080 1920];
camDim          = [3476 5208];

%%% Camera image coordinates where reconstruction is done

RowSt           = 1;
ColSt           = 1;
ImHeight        = camDim(1);
ImWidth         = camDim(2);
ImHeight        = min(ImHeight, camDim(1)-RowSt+1);
ImWidth         = min(ImWidth,  camDim(2)-ColSt+1);
medfiltParam    = [1 1];            %%% Parameter for median filtering




% Load captured structured lighting sequences.
disp('+ Loading data set...');
T{1}    = imread([dataDirname, rep_image_name]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Data Loaded  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Load column/row label for each pixel (i.e., decode codes).
%load([dataDirname, '\corrHamilt3.mat']);
% clear IDiff1 IDiff2
IC = corr{corr_index};
if(~exist('IR'))
    IR = IC;
end

D{1}        = IR;
D{2}        = IC;
clear IC IR;

%%% Filtering
D{1}        = medfilt2(D{1}, medfiltParam);
D{2}        = medfilt2(D{2}, medfiltParam);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Mask this data out later - using some measure %%%%%%%%%%%%%%%
% Eliminate invalid column/row estimates.
% Note: This will exclude pixels if either the column or row is missing.
%       D{j,k} is the column/row for "orientation" j and camera k.
%       mask{k} is the overal per-pixel mask for camera k.

D{1}(D{1} > projDim(1))     = NaN;
D{2}(D{2} > projDim(2))     = NaN;
D{1}(D{1} < 1)              = NaN;
D{2}(D{2} < 1)              = NaN;

%Only D{2} is used
% D{2}(1:659, :) = NaN;
% D{2}(3222:end, :) = NaN;
% D{2}(:, 1:1929) = NaN;
% D{2}(:, 5000:end) = NaN;

%D{2}  = D{2} * 1920 / 2 / pi;
% D{1}(D{1} > projDim(1))     = NaN;
% D{2}(D{2} > projDim(2))     = NaN;

%%% Removing data from outside the image bounds
D{1}([1:RowSt-1, RowSt+ImHeight:end], :)        = NaN;
D{2}([1:RowSt-1, RowSt+ImHeight:end], :)        = NaN;
D{1}(:, [1:ColSt-1, ColSt+ImWidth:end], :)      = NaN;
D{2}(:, [1:ColSt-1, ColSt+ImWidth:end], :)      = NaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Display projector column/row.
% figure; clf;
% imagesc(D{1}); axis image; colormap(jet(256)); colorbar
% title('Recovered Projector Row Indices'); drawnow;
% figure; clf;
% imagesc(D{2}); axis image; colormap(jet(256)); colorbar
% title('Recovered Projector Column Indices'); drawnow;
% figure; clf;
% image(T{1}); axis image; 
% title('Reference Image for Texture Mapping'); drawnow;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part II: Reconstruct surface using line-plane intersection.

% Reconstruct 3D points using intersection with illumination plane(s).
% Note: Reconstructs from all cameras in the first camera coordinate system.
disp('+ Reconstructing 3D points...');

if( HVFlag==1 )
    idx         = find(~isnan(D{2}));
    
elseif( HVFlag==2 )
    idx         = find(~isnan(D{1}));
end

idx         = idx(1:dSamplePlot:end);               %%%% Sub-sampling - for memory reasons

% [row,col]   = ind2sub(size(D{1}),idx);
npts        = length(idx);

if(HVFlag==1)
    
    vV                  = zeros(3, numel(idx));
    vVFloor             = zeros(3, numel(idx));
    vVCeil              = zeros(3, numel(idx));
    
    K=1;        %% For memory efficiency
    
    for t=1:K
        
        %%% Linear interpolation model to exploit sub-pixel information. Is
        %%% it accurate? 
        vVFloor(:,t:K:end)          = intersectLineWithPlane(repmat(Oc,1,numel(idx(t:K:end))), Nc(:,idx(t:K:end)), wPlaneCol(floor(D{2}(idx(t:K:end))),:)');
        vVCeil(:,t:K:end)           = intersectLineWithPlane(repmat(Oc,1,numel(idx(t:K:end))), Nc(:,idx(t:K:end)), wPlaneCol(ceil(D{2}(idx(t:K:end))),:)');
        
        alpha                       = D{2}(idx(t:K:end)) - floor(D{2}(idx(t:K:end)));
        alpha                       = repmat(alpha', [3 1]);
        
        vV(:,t:K:end)               = vVFloor(:,t:K:end) .* (1-alpha) + vVCeil(:,t:K:end) .* (alpha);

%         vV(:,t:K:end)          = intersectLineWithPlane(repmat(Oc,1,numel(idx(t:K:end))), Nc(:,idx(t:K:end)), wPlaneCol(round(D{2}(idx(t:K:end))),:)');
        
    end
    
    %clear Nc D
    vertices    = vV';
    %clear vV
    save([dataDirname, '\verticesColumn.mat'], 'vertices');
else
    
    vH                  = zeros(3, numel(idx));
    K=6;        %% For memory efficiency
    for t=1:K
        vH(:,t:K:end)       = intersectLineWithPlane(repmat(Oc,1,numel(idx(t:K:end))), Nc(:,idx(t:K:end)), wPlaneRow(round(D{1}(idx(t:K:end))),:)');
    end
    
    clear Nc D
    vertices    = vH';
    clear vH
    save([dataDirname, '\verticesRows.mat'], 'vertices');
end



%%%%%%%%% Getting the colors data %%%%%%%%%%%%

colors      = 0.65*ones(npts,3);
Rc          = im2double(T{1}(:,:,1));
if(size(T{1},3)>1)
    Gc          = im2double(T{1}(:,:,2));
    Bc          = im2double(T{1}(:,:,3));
else
    Gc  = Rc;
    Bc  = Rc;
end

colors(:,1) = Rc(idx);
colors(:,2) = Gc(idx);
colors(:,3) = Bc(idx);

clear Rc Gc Bc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part III: Display reconstruction results and export VRML model.

% Display status.
disp('+ Displaying results and exporting VRML model...');

% Display project/camera calibration results.
% procamCalibDisplay;

% Display the recovered 3D point cloud (with per-vertex color).
% Note: Convert to indexed color map for use with FSCATTER3.

% C           = reshape(colors, [size(colors,1) 1 size(colors,2)]);
% [C,cmap]    = rgb2ind(C,256);
% hold on;
% 
% figure;fscatter3(vertices(1:scatterSample:end,1), vertices(1:scatterSample:end,3), -vertices(1:scatterSample:end,2), double(C(1:scatterSample:end)),cmap);
% hold off;
% axis tight; drawnow;



clear row colors

% %%%% Making 2D structure files
StructX             = zeros(camDim(1), camDim(2));
StructY             = zeros(camDim(1), camDim(2));
StructZ             = zeros(camDim(1), camDim(2));
StructX(idx)        = vertices(:,1);
StructY(idx)        = vertices(:,2);
StructZ(idx)        = vertices(:,3);

clear vertices idx

vertices_subset     = cat(3, StructX(1601:2500, 2301:4800), StructY(1601:2500, 2301:4800), StructZ(1601:2500, 2301:4800));

StructX             = StructX';
StructY             = StructY';
StructZ             = StructZ';
vertices            = cat(3, StructX, StructY, StructZ);


if(HVFlag==1)
    save([dataDirname, '\verticesColumnAll.mat'], 'vertices');
else
    save([dataDirname, '\verticesRowsAll.mat'], 'vertices');
end

clear StructX StructY vertices




%%% Saving the depth-map image
StructZ             = StructZ';


% %%% ClayPot
% StructZ             = (StructZ - 1620)/ 150;

% %%% Man On Horse
% StructZ             = (1575 - StructZ) /75;
% 
% %%% White Bowl
% StructZ             = (1575 - StructZ) /75;

% %%% Wax Bowl
% StructZ             = (1610 - StructZ)/66;

% %%% Defocus Book
%StructZ             = (StructZ - 1400)/900;

%%% Bowl Color Codes
%StructZ             = (StructZ - 880)/120;

figure;imagesc(StructZ(1600:2500, 2300:4300)); axis image; colormap(gray(256)); colorbar
curr_depth_map = ['DepthMap', sprintf('%04d', corr_index), '.png'];
saveas(gcf, curr_depth_map);
figure;plot(StructZ(2000, 2300:4300));
plot_one_row = ['PlotOneRow', sprintf('%04d', corr_index), '.png'];
saveas(gcf, plot_one_row);



Depths_Subset = StructZ(1601:2500, 2301:4300);

if(HVFlag==1)
    imwrite(im2uint16(StructZ), [dataDirname, '\DepthMapColumns.png']); 
else
    imwrite(im2uint16(StructZ), [dataDirname, '\DepthMapRows.png']); 
end