% Determine mapping from projector pixels to optical rays.
% Note: Ideally, the projected images should be pre-warped to
%       ensure that projected planes are actually planar.
c = 1:nx_proj;
r = 1:ny_proj;

[C,R] = meshgrid(c,r);
zdum = zeros(ny_proj, nx_proj);
points3D = [C(:), R(:), zdum(:)]';

%X = [0 192 192 0; 0 0 192 192; 0 0 0 0]; %2D in proj ref frame
temp_here = ['Rc_',int2str(1),'_cam*points3D + repmat(Tc_',int2str(1),'_cam,1,size(points3D,2));']; %2D in cam ref frame
np  = pixel2ray([points3D(1, :) points3D(2,:)],fc_proj,cc_proj,kc_proj,alpha_c_proj);
%np = Rc_1_proj'*(np - Tc_1_proj*ones(1,size(np,2)));
Np = zeros([ny_proj nx_proj 3]);
Np(:,:,1) = reshape(np(1,:),ny_proj,nx_proj);
Np(:,:,2) = reshape(np(2,:),ny_proj,nx_proj);
Np(:,:,3) = reshape(np(3,:),ny_proj,nx_proj);
P = -Rc_1_proj'*Tc_1_proj; %I think this is the origin