%%
clear all
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
subdirname = '\Experiment Subset\Sine3';

corr_mat = [dirname, subdirname, '\corrSine3.mat'];
load(corr_mat);
for sli=1:18
    [vertices_Sine{sli}, Depths_Sine{sli}] = slReconstruct(sli, correspondence_sine3, subdirname, '\IMG_5412.tiff');
end
depth_path = [dirname, subdirname, '\Sine3All.mat'];
save(depth_path, 'vertices_Sine', 'Depths_Sine');


%%
clear all
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
subdirname = '\Experiment Subset\Hamilt5';

corr_mat = [dirname, subdirname, '\corrHamilt5ss2.mat'];
load(corr_mat)
for sli=1:18
    [vertices_Hamilt{sli}, Depths_Hamilt{sli}] = slReconstruct(sli, corrHamilt5ss2, subdirname, '\IMG_5142.tiff');
end
depth_path = [dirname, subdirname, '\Hamilt5All.mat'];
save(depth_path, 'vertices_Hamilt', 'Depths_Hamilt');

%%
clear all
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
subdirname = '\Publishable\ProcK5All\Hilbert5';

corr_mat = [dirname, subdirname, '\corr_hilbert5.mat'];
load(corr_mat)
for sli=1:36
    [vertices_Hilbert{sli}, Depths_Hilbert{sli}] = slReconstruct(sli, corr_hilbert5, subdirname, '\IMG_9730.tiff');
end
depth_path = [dirname, subdirname, '\Hamilt5All.mat'];
save(depth_path, 'vertices_Hilbert', 'Depths_Hilbert');

%%
clear all
dirname = 'C:\Users\Nikhil\Desktop\Corrected_GeometricNew\Geometric';
subdirname = '\Publishable\ProcK5All\EP5';

corr_mat = [dirname, subdirname, '\Depths_EP5.mat'];
load(corr_mat)
for sli=1:36
    [vertices_EP{sli}, Depths_EP{sli}] = slReconstruct(sli, Depths, subdirname, '\IMG_9910.tiff');
end
depth_path = [dirname, subdirname, '\EP5All.mat'];
save(depth_path, 'vertices_EP', 'Depths_EP');