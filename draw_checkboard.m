I       = zeros(1080, 1920);
IS      = [ones(64,64) zeros(64,64); zeros(64,64) ones(64,64)];
IS      = repmat(IS, [5 5]);
I(101:740, 101:740) = IS;
I       = repmat(I, [1 1 3]);
I       = im2uint8(I);
