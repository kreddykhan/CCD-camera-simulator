function intensity = camera_integrals_large(x1,y1,x2,y2,x3,y3,x4,y4,RGB,pixel_number,rotation)
tic
% RGB = RGB;
magnification = 1;
pixels_number = (pixel_number)*magnification;
correction = floor(length(RGB)/2);

locations = ones(pixels_number,pixels_number*2);
intensity = ones(pixels_number-1,pixels_number-1);

% x1 = 100;
% y1 = 100;
% 
% x2 = 7600;
% y2 = 100;
% 
% x3 = 100;
% y3 = 7600;
% 
% x4 = 7600;
% y4 = 7600;

% y11 = x1 - correction;
% x11 = y1 - correction;
% y21 = x2 - correction;
% x21 = y2 - correction;
% y31 = x3 - correction;
% x31 = y3 - correction;
% y41 = x4 - correction;
% x41 = y4 - correction;
% % 
% x1 = x11;
% y1 = y11;
% x2 = x21;
% y2 = y21;
% x3 = x31;
% y3 = y31;
% x4 = x41;
% y4 = y41;

% x1 = 2;
% y1 = 6;
% 
% x2 = 1;
% y2 = 2;
% 
% x3 = 7;
% y3 = 7;
% 
% x4 = 8;
% y4 = 1;

%%
left_line = [x1 y1; x2 y2];
left_line_length = pdist(left_line);

right_line = [x3 y3; x4 y4];
right_line_length = pdist(right_line);

left_line_points = ones(pixels_number,2);
right_line_points = ones(pixels_number,2);

left_line_points(1,1) = x1;
left_line_points(1,2) = y1;

right_line_points(1,1) = x3;
right_line_points(1,2) = y3;

if x1~=x2
    left_slope = (y1 - y2)/(x1-x2);
    left_line_angle = atan(left_slope);
    rad2deg(left_line_angle);
else
    left_slope = 1;
    left_line_angle = deg2rad(90);
end

if x3~=x4
    right_slope = (y3 - y4)/(x3-x4);
    right_line_angle = atan(right_slope);
else
    right_slope = 1;
    right_line_angle = deg2rad(90);
end

left_increments = left_line_length/(pixels_number);
left_increments_x = left_increments*cos(left_line_angle);
left_increments_y = left_increments*sin(left_line_angle);

right_increments = right_line_length/(pixels_number);
right_increments_x = right_increments*cos(right_line_angle);
right_increments_y = right_increments*sin(right_line_angle);

if x1>x2 & left_increments_x>0
    left_increments_x = -1*left_increments_x;
end

if x2>x1 & left_increments_x<0
    left_increments_x = -1*left_increments_x;
end

if y1>y2 & left_increments_y>0
    left_increments_y = -1*left_increments_y;
end

if y2>y1 & left_increments_y<0
    left_increments_y = -1*left_increments_y;
end

if x3>x4 & right_increments_x>0
    right_increments_x = -1*right_increments_x;
end

if x4>x3 & right_increments_x<0
    right_increments_x = -1*right_increments_x;
end

if y3>y4 & right_increments_y>0
    right_increments_y = -1*right_increments_y;
end

if y4>y3 & right_increments_y<0
    right_increments_y = -1*right_increments_y;
end

x_start = x1;
y_start = y1;

for n = 2:1:pixels_number + 1
    x_start = x_start + (left_increments_x);
    left_line_points(n,1) = x_start;
    y_start = y_start + (left_increments_y);
    left_line_points(n,2) = y_start;
end

x_start = x3;
y_start = y3;

for n = 2:1:pixels_number + 1
    x_start = x_start + (right_increments_x);
    right_line_points(n,1) = x_start;
    y_start = y_start + (right_increments_y);
    right_line_points(n,2) = y_start;
end

left_line_points;
right_line_points;

%%
for n=1:1:length(left_line_points)
    x_start = left_line_points(n,1);
    y_start = left_line_points(n,2);
    x_end = right_line_points(n,1);
    y_end = right_line_points(n,2);
    
    line = [x_start y_start; x_end y_end];
    line_length = pdist(line);
    
    line_points = ones(pixels_number*2,1);
    line_points(1) = x_start;
    line_points(2) = y_start;
    
    if y_start~=y_end & x_start~=x_end
        line_slope = (y_start-y_end)/(x_start-x_end);
        line_angle = atan(line_slope);
    else
        line_slope = 1;
        line_angle = deg2rad(rotation);
%         line_angle = 0;
%         line_angle = deg2rad(90);
    end
    
    line_increments = line_length/(pixels_number);
    line_increments_x = line_increments*cos(line_angle);
    line_increments_y = line_increments*sin(line_angle);
    
    if x_start>x_end & line_increments_x>0
        line_increments_x = -1*line_increments_x;
    end
    
    if y_start>y_end & line_increments_y>0
        line_increments_y = -1*line_increments_y;
    end
    
    x_point = x_start;
    y_point = y_start;
    
    for m = 3:2:pixels_number*2
        x_point = x_point + (line_increments_x);
        line_points(m) = x_point;
        y_point = y_point + (line_increments_y);
        line_points(m+1) = y_point;
    end
    assignin('base','line_points',line_points);
    
    for k = 1:1:length(line_points)
        locations(n,k) = line_points(k);
    end
    line_points;
end

%%
locations;
locations = locations+correction;

assignin('base','locations',locations);


for n=1:1:(size(locations,1)-1)
    count = 0;
    for m=1:2:(size(locations,2)-3)
        count = count+1;
    x1 = locations(n,m);
    y1 = locations(n,m+1);
    
    x2 = locations(n+1,m);
    y2 = locations(n+1,m+1);
    
    x3 = locations(n,m+2);
    y3 = locations(n,m+3);
    
    x4 = locations(n+1,m+2);
    y4 = locations(n+1,m+3);
%     intensity_single = camera_integrals(x1,y1,x2,y2,x3,y3,x4,y4,RGB);
    intensity(n,count) = camera_integrals(x1,y1,x2,y2,x3,y3,x4,y4,RGB);
    end
end

% intensity;
figure,imshow(intensity')
% intensity = 1;
toc
end