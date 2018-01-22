TRZ = StructZ';
FlatZ = TRZ(:);
FlatY = StructY(:);
FlatX = StructX(:);
FLATS = [FlatX, FlatY, FlatZ];
figure; pcshow(FLATS)