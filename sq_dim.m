for ooo = 1:16
    eval(['n_sq_y_', num2str(ooo), '= 33']);
    eval(['n_sq_x_', num2str(ooo), '= 33']);
    save([basedirname, '\proj\calib_data.mat'],['n_sq_y_', num2str(ooo)],'-append');
    save([basedirname, '\proj\calib_data.mat'],['n_sq_x_', num2str(ooo)],'-append');
end