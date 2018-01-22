%%
for var1=1:36
    err_ham3{var1} = Depths_Hamilt3GT{1} - Depths_Hamilt3{var1};
    err_ham3{var1} = double(mean(abs(err_ham3{var1}(:))));
end
err_ham3 = reshape(err_ham3, [6, 6]);
err_ham3 = err_ham3';
save('err_ham3.mat', 'err_ham3');
%%
for var1=1:36
    err_Tri3{var1} = Depths_Hamilt3GT{1} - Depths_Hilbert3{var1};
    err_Tri3{var1} = double(mean(abs(err_Tri3{var1}(:))));
end
err_Tri3 = reshape(err_Tri3, [6, 6]);
err_Tri3 = err_Tri3';
save('err_Tri3.mat', 'err_Tri3');
%%
for var1=1:36
    err_sin3{var1} = Depths_Sine3GT{1} - Depths_Sine3{var1};
    err_sin3{var1} = double(mean(abs(err_sin3{var1}(:))));
end
err_sin3 = reshape(err_sin3, [6, 6]);
err_sin3 = err_sin3';
save('err_sin3.mat', 'err_sin3');