%Script that applies horizontal and vertical Sobel filter

clc;
clear all;

load iptest_im iptest256a;

%padding image by one layer of zeros
iptest256a = vertcat(zeros(1,256),iptest256a,zeros(1,256));
iptest256a = horzcat(zeros(258,1),iptest256a,zeros(258,1));

%filters:
sobel_x = [-1 -2 -1;0 0 0;1 2 1];
sobel_y = [-1 0 1;-2 0 2;-1 0 1];

%result_x = zeros(256,256); %contains result from applying horizontal mask
%result_y = zeros(256,256); %contains result from applying vertical mask
result = zeros(256,256);    %contains result from applying both mask 

for i = 2:257
    for j = 2:257
        
        %temp_res_x and temp_res_y holds sum from masks
        temp_res_x = 0;
        temp_res_y = 0;
        
        %k and j used to apply 3x3 mask
        for k = -1:1
            for l = -1:1
                temp_res_x = temp_res_x + (double(iptest256a(i+k,j+l))*sobel_x(2+k,2+l));
                temp_res_y = temp_res_y + (double(iptest256a(i+k,j+l))*sobel_y(2+k,2+l));
            end
        end
        
        %result_x(i-1,j-1) = abs(temp_res_x);
        %result_y(i-1,j-1) = abs(temp_res_y);
        result(i-1,j-1) = abs(temp_res_x)+abs(temp_res_y);
    end
end

%r1 = uint8(result_x);
%r2 = uint8(result_y);
%figure(1);
%ip_disp(r1);
%title('Image after applying horizontal Sobel mask');
%figure(2);
%ip_disp(r2);
%title('Image after applying vertical Sobel mask');
r3 = uint8(result);
figure(3);
ip_disp(r3);
title('Image after applying horizontal and vertical Sobel mask');