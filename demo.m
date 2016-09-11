pepper = imread('peppers.png');
pepper_BW = im2bw(pepper);
pepper_BW = pepper_BW(1:384,1:384);
figure, imshow(pepper_BW)

pixel_number = 26;
pixel_unit = 5;
x0 = 192;
y0 = 192;
x_translation_0 = 0;
y_translation_0 = 0;
magnification =1;
rotation = 0;
RGB = pepper_BW;

output = camera_points(pixel_number,pixel_unit,x0,y0,x_translation_0,y_translation_0,magnification,rotation,RGB);