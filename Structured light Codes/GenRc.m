for i=1:256
    Rc{i} = i * ones(1280,1920);
    Rc{i} = uint8(Rc{i});
    imwrite(Rc{i}, sprintf('Rc_%d.tiff', i));
end