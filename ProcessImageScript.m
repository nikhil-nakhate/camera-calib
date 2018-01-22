
file_arr = dir('*.CR2');
%dirname         = ['C:\Users\user\Desktop\EP5'];
% indices1         = 5155:5164;
% indices2         = 5166:5171;
%indices          = [indices1 indices2];
% indices         = 5197:5199;
    
for i=1:numel(file_arr)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
    %fname = ['IMG_', sprintf('%04d', indices(i)), '.CR2']
    %fname2 = ['IMG_', sprintf('%04d', indices(i)), '.png']
    dos(['dcraw -v -4 -q 3 -T ', file_arr(i).name]);
    %fname2 = ['IMG_', sprintf('%04d', indices(i)), '.tiff'];
    %imhh = imread(fname2);
    %imhh2 = im2double(imhh);
    %fname3 = ['IMG_', sprintf('%04d', indices(i)), '.tif'];
    %imwrite(imhh2, fname3);
    %dos(['dcraw -v -4 -q 3 ', fname,' | pnmtopng > ', fname2])
    %dos(['dcraw -b 3.0 -v -4 -q 3 ', fname])
    %expVal = FindExposure(fname)
    %imwrite
end