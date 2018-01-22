for i=[1,15,36]
figure;imagesc(err_sinABS5{i}); axis image; colormap(gray(256)); colorbar
curr_depth_map = ['ErrorMap', sprintf('%02d', i), '.png'];
saveas(gcf, curr_depth_map);
end

for var1=[6,15,31]
err_sin_non_abs4{var1} = Depths_Sine3GT{1}(1:2001) - Depths_Sine4{var1};
end

% (:, 2:end)

for var1=1:36
    err_sin{var1} = Depths_GT5{1} - Depths_Hamilt4{var1};
    err_sin{var1} = double(mean(abs(err_sin{var1}(:))));
end
err_sin = reshape(err_sin, [6, 6]);
err_sin = err_sin';
save('depth_err_sin.mat', 'err_sin');

for i=[6,15,31]
plot(err_sin_non_abs4{i}(450, :), 'r-'); hold;figure;plot(err_ham_non_abs4{i}(450, :), 'g-');
plot_one_row = ['PlotOneRowErrorMap', sprintf('%02d', i), '.png'];
saveas(gcf, plot_one_row);
end





for i=[6,15,31]
figure;plot(err_sin_non_abs4{i}(450, :), 'r-'); hold;plot(err_ham_non_abs4{i}(450, :), 'g-');
ylim([-200 200])
plot_one_row = ['PlotOneRowErrorMap4', sprintf('%02d', i), '.png'];
saveas(gcf, plot_one_row);
end


for i=[6,15,31]
figure;imagesc(err_sin_non_abs5{i}); axis image; colormap(gray(256)); colorbar;caxis([-200 200])
curr_depth_map = ['ErrorMapSin5', sprintf('%02d', i), '.png'];
saveas(gcf, curr_depth_map);
end