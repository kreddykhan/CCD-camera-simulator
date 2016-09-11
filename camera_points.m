function output = camera_points(pixel_number,pixel_unit,x0,y0,x_translation_0,y_translation_0,magnification,rotation,RGB)

pixel_unit = pixel_unit*magnification;
x = x0;
y = y0;
x_translation = x_translation_0;
y_translation = y_translation_0;

x = x + x_translation;
y = y + y_translation;

correction = floor(length(RGB)/2);

difference = (pixel_number*pixel_unit)/2;

x1 = x-difference;
y1 = y-difference;

x2 = x-difference;
y2 = y+difference;

x3 = x+difference;
y3 = y-difference;

x4 = x+difference;
y4 = y+difference;

thing = [x1 y1 x2 y2 x3 y3 x4 y4];

theta = deg2rad(rotation);

R = [cos(theta) -sin(theta); sin(theta) cos(theta)];

x1 = x1 - x0;
y1 = y1 - y0;
temp1 = [x1;y1];

x2 = x2 - x0;
y2 = y2 - y0;
temp2 = [x2;y2];

x3 = x3 - x0;
y3 = y3 - y0;
temp3 = [x3;y3];

x4 = x4 - x0;
y4 = y4 - y0;
temp4 = [x4;y4];

temp1 = R*temp1;
temp2 = R*temp2;
temp3 = R*temp3;
temp4 = R*temp4;


temp1(1) = temp1(1) + x0;
temp1(2) = temp1(2) + y0;
temp2(1) = temp2(1) + x0;
temp2(2) = temp2(2) + y0;
temp3(1) = temp3(1) + x0;
temp3(2) = temp3(2) + y0;
temp4(1) = temp4(1) + x0;
temp4(2) = temp4(2) + y0;

x11 = temp1(1);
y11 = temp1(2);
x21 = temp2(1);
y21 = temp2(2);
x31 = temp3(1);
y31 = temp3(2);
x41 = temp4(1);
y41 = temp4(2);

thing = cat(1,thing,[x11 y11 x21 y21 x31 y31 x41 y41]);

x_value_min = min(min(x11,x21),min(x31,x41));
x_value_max = max(max(x11,x21),max(x31,x41));
y_value_min = min(min(y11,y21),min(y31,y41));
y_value_max = max(max(y11,y21),max(y31,y41));

x11 = temp1(1) - correction;
y11 = temp1(2) - correction;
x21 = temp2(1) - correction;
y21 = temp2(2) - correction;
x31 = temp3(1) - correction;
y31 = temp3(2) - correction;
x41 = temp4(1) - correction;
y41 = temp4(2) - correction;

x1 = x11;
y1 = y11;
x2 = x21;
y2 = y21;
x3 = x31;
y3 = y31;
x4 = x41;
y4 = y41;

thing = cat(1,thing,[x1 y1 x2 y2 x3 y3 x4 y4])

output = camera_integrals_large(x1,y1,x2,y2,x3,y3,x4,y4,RGB,pixel_number,rotation);

end