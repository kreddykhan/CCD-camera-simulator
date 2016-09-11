function intensity = camera_integrals(x1,y1,x2,y2,x3,y3,x4,y4,RGB)
% RGB = RGB;
% 
% x1 = 100;
% y1 = 200;
% 
% x2 = 100;
% y2 = 200;
% 
% x3 = 200;
% y3 = 100;
% 
% x4 = 200;
% y4 = 200;

thing = [x1,x2,x3,x4,y1,y2,y3,y4];
assignin('base','thing',thing);

pixel_bins = 49;

left_line = [x1 y1; x2 y2];
left_line_length = pdist(left_line);

right_line = [x3 y3; x4 y4];
right_line_length = pdist(right_line);

left_line_points = ones(pixel_bins+1,2);
right_line_points = ones(pixel_bins+1,2);

left_line_points(1,1) = x1;
left_line_points(1,2) = y1;

right_line_points(1,1) = x3;
right_line_points(1,2) = y3;

if x1~=x2
    left_slope = (y1 - y2)/(x1-x2);
    left_line_angle = atan(left_slope);
%     left_line_angle = rad2deg(left_line_angle);
else
    left_slope = 1;
    left_line_angle = deg2rad(90);
end

if x3~=x4
    right_slope = (y3 - y4)/(x3-x4);
    right_line_angle = atan(right_slope);
%     right_line_angle = rad2deg(right_line_angle);
else
    right_slope = 1;
    right_line_angle = deg2rad(90);
end

left_increments = left_line_length/pixel_bins;
left_increments_x = left_increments*cos(left_line_angle);
left_increments_y = left_increments*sin(left_line_angle);

right_increments = right_line_length/pixel_bins;
right_increments_x = right_increments*cos(right_line_angle);
right_increments_y = right_increments*sin(right_line_angle);

if x1>x2
    left_increments_x = -1*left_increments_x;
end

if y1>y2
    left_increments_y = -1*left_increments_y;
end

if x3>x4
    right_increments_x = -1*right_increments_x;
end

if y3>y3
    right_increments_y = -1*right_increments_y;
end

x_start = x1;
y_start = y1;

for n = 2:1:pixel_bins+1
    x_start = x_start + (left_increments_x);
    left_line_points(n,1) = x_start;
    y_start = y_start + (left_increments_y);
    left_line_points(n,2) = y_start;
end

x_start = x3;
y_start = y3;

for n = 2:1:pixel_bins+1
    x_start = x_start + (right_increments_x);
    right_line_points(n,1) = x_start;
    y_start = y_start + (right_increments_y);
    right_line_points(n,2) = y_start;
end

values = ones(pixel_bins+1,pixel_bins+1);
size(values);

for n=1:1:length(left_line_points)
    x_start = left_line_points(n,1);
    y_start = left_line_points(n,2);
    x_end = right_line_points(n,1);
    y_end = right_line_points(n,2);
    
    line = [x_start y_start; x_end y_end];
    line_length = pdist(line);
    
    line_points = ones(pixel_bins+1,2);
    line_points(1,1) = x_start;
    line_points(1,2) = y_start;
    
    if y_start~=y_end
        line_slope = (y_start-y_end)/(x_start-x_end);
        line_angle = atan(line_slope);
    else
        line_slope = 1;
        line_angle = 0;
    end
    
    line_increments = line_length/pixel_bins;
    line_increments_x = line_increments*cos(line_angle);
    line_increments_y = line_increments*sin(line_angle);
    
    if x_start>x_end
        line_increments_x = -1*line_increments_x;
    end
    
    if y_start>y_end
        line_increments_y = -1*line_increments_y;
    end
    
    x_point = x_start;
    y_point = y_start;
    
    for m = 2:1:pixel_bins+1
        x_point = x_point + (line_increments_x);
        line_points(m,1) = x_point;
        y_point = y_point + (line_increments_y);
        line_points(m,2) = y_point;
    end
    
    line_points;
        
    for k = 1:1:length(line_points)
%         values(n,k) = RGB(round(line_points(k,2)+correction),round(line_points(k,1)+correction));
        line_points(k,1);
        line_points(k,2);
        values(n,k) = RGB(round(line_points(k,1)),round(line_points(k,2)));
        assignin('base','line_points',line_points);
    end
end

values = values';
% figure,imshow(values)

assignin('base','values',values)
assignin('base','left_line_points',left_line_points)
assignin('base','right_line_points',right_line_points)

intensity = (sum(sum(values)))/(size(values,1)*size(values,2));

end