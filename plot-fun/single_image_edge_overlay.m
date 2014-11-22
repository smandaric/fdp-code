height = 865;
width = 974;

test8 = zeros(height,width,3);

for h = 1:height
    for w = 1:width
        if test2(h,w) == 1
            test8(h,w,1)  = 255;
            test8(h,w,2)  = 0;
            test8(h,w,3)  = 0;
        else
            test8(h,w,1) = floor(img(h,w,1,204));
            test8(h,w,2) = floor(test8(h,w,1));
            test8(h,w,3) = floor(test8(h,w,1));
        end
    end
end
imshow(uint8(test8))
