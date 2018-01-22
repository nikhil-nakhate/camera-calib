for hello = 1:16
    curr = 5154 + hello;
    image_name = sprintf('IMG_%d.tif',curr)
    reading_image = imread(image_name);
    if(size(reading_image, 3) == 1)
        I = double(reading_image);
    else
        I = double(rgb2gray(reading_image));
    end
    wintx = 41;
    winty = 41;
    [x,dumb,n_sq_x,n_sq_y] = extract_grid(I,wintx,winty );%,wintx,winty,fc,cc,kc,dX,dY);
    xx{hello} = x;
    
    [Tc,Rc,H] = computeExtrinsic(fc_cam, cc_cam, kc_cam, alpha_c_cam, frame, ImSuffix, proj_cal_nX, proj_cal_nY, proj_cal_dX, proj_cal_dY);
       eval(['Rc_',int2str(hello),' = Rc']);
       eval(['Tc_',int2str(hello),' = Tc']);
       if hello == 1
           save([basedirname, '\proj\ext_calib_data.mat'],['Rc_',int2str(hello)]);
       else
           save([basedirname, '\proj\ext_calib_data.mat'],['Rc_',int2str(hello)],'-append');
       end
       save([basedirname, '\proj\ext_calib_data.mat'],['Tc_',int2str(hello)],'-append');
end
for ww = 1:16
    eval(['x_',int2str(ww),' = xx{ww}']);
end