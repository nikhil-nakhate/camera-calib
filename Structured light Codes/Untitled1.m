k = dir('E:\6X6 Images Proj1 Min\Cube\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname=k(i).name;
    Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

for i=1:144
Test{i}=reshape(Test{i},1,3476*5208);
end

for pic=0:5
    ind=(4*pic)+1;
     Image{1}= Test{ind};
     Image{2}= Test{ind+1};
     Image{3}= Test{ind+2};
     Image{4}= Test{ind+3};
     Codes= [Image{1};Image{2};Image{3};Image{4}];
     [i,column]= DecodeHilbertDimOne(Codes, 1920);
     %[i,column]= DecodeHilbertDimTwoThree(Codes, 1920, 2, 1, 0.25);
     column=reshape(column,3476,5208);
     column(column>2000)=0;
     column(column<0)=0;
     correspondence_cube{pic+1}=column;
     clear Codes
     clear column
     clear i
end
clear Test

k = dir('E:\Design images with 0.05\Camera Exposure1\Proj1 Min\Hilbert 0.05\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname=k(i).name;
    Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

for i=1:8
Test{i}=reshape(Test{i},1,3476*5208);
end

for pic=0:1
    ind=(4*pic)+1;
     Image{1}= Test{ind};
     Image{2}= Test{ind+1};
     Image{3}= Test{ind+2};
     Image{4}= Test{ind+3};
     Codes= [Image{1};Image{2};Image{3};Image{4}];
     %[i,column]= DecodeHilbertDimOne(Codes, 1920);
     [i,column]= DecodeHilbertDimTwoThree(Codes, 1920, 2, 1, 0.25);
     column=reshape(column,3476,5208);
     column(column>2000)=0;
     column(column<0)=0;
     correspondence_hilbert_m_1_5{pic+1}=column;
     clear Codes
     clear column
     clear i
end
clear Test

k = dir('E:\Design images with 0.05\Camera Exposure2\Default Proj1\Hilbert\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname=k(i).name;
    Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

for i=1:40
Test{i}=reshape(Test{i},1,3476*5208);
end

for pic=0:9
    ind=(4*pic)+1;
     Image{1}= Test{ind};
     Image{2}= Test{ind+1};
     Image{3}= Test{ind+2};
     Image{4}= Test{ind+3};
     Codes= [Image{1};Image{2};Image{3};Image{4}];
     %[i,column]= DecodeHilbertDimOne(Codes, 1920);
     [i,column]= DecodeHilbertDimTwoThree(Codes, 1920, 2, 1, 0.25);
     column=reshape(column,3476,5208);
     column(column>2000)=0;
     column(column<0)=0;
     correspondence_hilbert_d_2{pic+1}=column;
     clear Codes
     clear column
     clear i
end
clear Test

k = dir('E:\Design images with 0.05\Camera Exposure2\Proj1 Min\Hilbert\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname=k(i).name;
    Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

for i=1:40
Test{i}=reshape(Test{i},1,3476*5208);
end

for pic=0:9
    ind=(4*pic)+1;
     Image{1}= Test{ind};
     Image{2}= Test{ind+1};
     Image{3}= Test{ind+2};
     Image{4}= Test{ind+3};
     Codes= [Image{1};Image{2};Image{3};Image{4}];
     %[i,column]= DecodeHilbertDimOne(Codes, 1920);
     [i,column]= DecodeHilbertDimTwoThree(Codes, 1920, 2, 1, 0.25);
     column=reshape(column,3476,5208);
     column(column>2000)=0;
     column(column<0)=0;
     correspondence_hilbert_m_2{pic+1}=column;
     clear Codes
     clear column
     clear i
end
clear Test

k = dir('E:\Design images with 0.05\Camera Exposure3\Default Proj1\Hilbert 0.05\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname=k(i).name;
    Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

for i=1:8
Test{i}=reshape(Test{i},1,3476*5208);
end

for pic=0:1
    ind=(4*pic)+1;
     Image{1}= Test{ind};
     Image{2}= Test{ind+1};
     Image{3}= Test{ind+2};
     Image{4}= Test{ind+3};
     Codes= [Image{1};Image{2};Image{3};Image{4}];
     %[i,column]= DecodeHilbertDimOne(Codes, 1920);
     [i,column]= DecodeHilbertDimTwoThree(Codes, 1920, 2, 1, 0.25);
     column=reshape(column,3476,5208);
     column(column>2000)=0;
     column(column<0)=0;
     correspondence_hilbert_d_3_5{pic+1}=column;
     clear Codes
     clear column
     clear i
end
clear Test


k = dir('E:\Design images with 0.05\Camera Exposure3\Proj1 Min\Hilbert 0.05\*.tiff');
filenames = {k.name}';
for i=1:numel(k)
    %fname = [dirname,'\IMG_', sprintf('%04d', indices(i)), '.CR2']
     %fname = ['IMG_', sprintf('%04d', indices(i)), '.tiff']
    fname=k(i).name;
    Test{i}=rgb2gray(im2double(imread(fname)));
    %expVal = FindExposure(fname)
    %imwrite
end

for i=1:8
Test{i}=reshape(Test{i},1,3476*5208);
end

for pic=0:1
    ind=(4*pic)+1;
     Image{1}= Test{ind};
     Image{2}= Test{ind+1};
     Image{3}= Test{ind+2};
     Image{4}= Test{ind+3};
     Codes= [Image{1};Image{2};Image{3};Image{4}];
     %[i,column]= DecodeHilbertDimOne(Codes, 1920);
     [i,column]= DecodeHilbertDimTwoThree(Codes, 1920, 2, 1, 0.25);
     column=reshape(column,3476,5208);
     column(column>2000)=0;
     column(column<0)=0;
     correspondence_hilbert_m_3_5{pic+1}=column;
     clear Codes
     clear column
     clear i
end
clear Test

