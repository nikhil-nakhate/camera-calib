%%
clear all
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
subdirname = '\Publishable\GT\Sine5GT';

corr_mat = [dirname, subdirname, '\correspondence_sine5GT.mat'];
load(corr_mat);
for sli=1
    [vertices_Sine{sli}, Depths_Sine{sli}] = slReconstruct(sli, correspondence_sine5_row, subdirname, '\SINE_GT1.tiff');
end
depth_path = [dirname, subdirname, '\Sine5GTAll.mat'];
save(depth_path, 'vertices_Sine', 'Depths_Sine');


%%
clear all
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
subdirname = '\Publishable\GT\Hamilt5GT';

corr_mat = [dirname, subdirname, '\corrHamilt5GT.mat'];
load(corr_mat)
for sli=1
    [vertices_Hamilt{sli}, Depths_Hamilt{sli}] = slReconstruct(sli, Depths, subdirname, '\HAMILT_GT1.tiff');
end
depth_path = [dirname, subdirname, '\Hamilt5GTAll.mat'];
save(depth_path, 'vertices_Hamilt', 'Depths_Hamilt');

%%
clear all
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
subdirname = '\Publishable\ProcK3All\Tri3';

corr_mat = [dirname, subdirname, '\correspondence_tri.mat'];
load(corr_mat)
for sli=1:36
    [vertices_Tri{sli}, Depths_Tri{sli}] = slReconstruct(sli, correspondence_tri, subdirname, '\IMG_1130.tiff');
end
depth_path = [dirname, subdirname, '\Tri3All.mat'];
save(depth_path, 'vertices_Tri', 'Depths_Tri');

%%
clear all
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
subdirname = '\Publishable\ProcK3All\Ramp3';

corr_mat = [dirname, subdirname, '\Ramp.mat'];
load(corr_mat)
for sli=1:36
    [vertices_Ramp{sli}, Depths_Ramp{sli}] = slReconstruct(sli, correspondence_ramp_column, subdirname, '\IMG_1129.tiff');
end
depth_path = [dirname, subdirname, '\RampAll.mat'];
save(depth_path, 'vertices_Ramp', 'Depths_Ramp');