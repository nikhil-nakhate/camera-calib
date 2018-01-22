
% Plot camera calibration results (in camera coordinate system).
figure; clf; %set(gcf,'Renderer','OpenGL');

IP   = 5*dX_cam*[1 -alpha_c_cam 0; 0 1 0;0 0 1]*...
    [1/fc_cam(1) 0 0; 0 1/fc_cam(2) 0; 0 0 1]*...
    [1 0 -cc_cam(1); 0 1 -cc_cam(2); 0 0 1]*...
    [0 nx_cam-1 nx_cam-1 0 0; 0 0 ny_cam-1 ny_cam-1 0; 1 1 1 1 1];
BASE = 5*dX_cam*[0 1 0 0 0 0; 0 0 0 1 0 0; 0 0 0 0 0 1];
IP = reshape([IP; BASE(:,1)*ones(1,5); IP],3,15);
hold on;
BASE = Rc_1_cam*Rc_1_cam'*(BASE - Tc_1_cam*ones(1,6)) + Tc_1_cam*ones(1,6);
IP =  Rc_1_cam*Rc_1_cam'*(IP - Tc_1_cam*ones(1,15)) + Tc_1_cam*ones(1,15);
plot3(BASE(1,:),BASE(3,:),-BASE(2,:),'b-','linewidth',2);
plot3(IP(1,:),IP(3,:),-IP(2,:),'r-','linewidth',2);
u = [6*dX_cam 0 0; -dX_cam 0 5*dX_cam; ...
    0 6*dX_cam 0; -dX_cam -dX_cam -dX_cam]';
u = Rc_1_cam*Rc_1_cam'*(u - Tc_1_cam*ones(1,4)) + Tc_1_cam*ones(1,4);
text(u(1,1),u(3,1),-u(2,1),['X']);
text(u(1,2),u(3,2),-u(2,2),['Z']);
text(u(1,3),u(3,3),-u(2,3),['Y']);
text(u(1,4),u(3,4),-u(2,4),['O']);
hold off;

   
% Plot projector calibration results (in camera coordinate system).
IP   = 5*dX_proj*[1 -alpha_c_proj 0; 0 1 0;0 0 1]*...
   [1/fc_proj(1) 0 0; 0 1/fc_proj(2) 0; 0 0 1]*...
   [1 0 -cc_proj(2); 0 1 -cc_proj(1); 0 0 1]*...                  %made change here
   [0 nx_proj-1 nx_proj-1 0 0; 0 0 ny_proj-1 ny_proj-1 0; 1 1 1 1 1];
BASE = 5*dX_proj*[0 1 0 0 0 0; 0 0 0 1 0 0; 0 0 0 0 0 1];
IP = reshape([IP; BASE(:,1)*ones(1,5); IP],3,15);
BASE = Rc_1_proj'*(BASE - Tc_1_proj*ones(1,6));
IP = Rc_1_proj'*(IP - Tc_1_proj*ones(1,15));
hold on;
plot3(BASE(1,:),BASE(3,:),-BASE(2,:),'b-','linewidth',2);
plot3(IP(1,:),IP(3,:),-IP(2,:),'g-','linewidth',2);
  
  %%% Adding planes from projector
  %plot3(Sx1, Sy1, Sz1,'g-','linewidth',2); plot3(Sx4, Sy4, Sz4, 'g-','linewidth',2);plot3(Sx5, Sy5, Sz5,'g-','linewidth',2);
  
% Sx1 = [P(1); Np(:,1,1)]; Sy1 = [P(2); Np(:,1,2)]; Sz1 = [P(3); Np(:,1,3)];
% Sx2 = [P(1); Np(:,100,1)]; Sy2 = [P(2); Np(:,100,2)]; Sz2 = [P(3); Np(:,100,3)];
% Sx3 = [P(1); Np(:,200,1)]; Sy3 = [P(2); Np(:,200,2)]; Sz3 = [P(3); Np(:,200,3)];
% Sx4 = [P(1); Np(:,300,1)]; Sy4 = [P(2); Np(:,300,2)]; Sz4 = [P(3); Np(:,300,3)];

% hold on;plot3(Sx1, Sy1, Sz1,'g-','linewidth',2); plot3(Sx2, Sy2, Sz2, 'g-','linewidth',2);plot3(Sx2, Sy2, Sz2,'g-','linewidth',2);
  
  u = [6*dX_proj 0 0; -dX_proj 0 5*dX_proj; ...
       0 6*dX_proj 0; -dX_proj -dX_proj -dX_proj]';
  u = Rc_1_proj'*(u - Tc_1_proj*ones(1,4));
  text(u(1,1),u(3,1),-u(2,1),'X_p');
  text(u(1,2),u(3,2),-u(2,2),'Z_p');
  text(u(1,3),u(3,3),-u(2,3),'Y_p');
  text(u(1,4),u(3,4),-u(2,4),'O_p');
hold off;
set(gcf,'Name','Projector/Camera Calibration Results');
xlabel('X_c'); ylabel('Z_c'); zlabel('Y_c');
view(50,20); grid on; rotate3d on;
axis equal tight vis3d;
