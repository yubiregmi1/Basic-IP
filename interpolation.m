%Script to scale the image
%Desired scaling is chosen by uncommenting desired scaling factors and 
%commenting other factors from line 15, 16 and 17

clc;
clear all;

load iptest_im iptest256a;

%padding the image by one layer of zeros 
iptest256a = vertcat(zeros(1,256),iptest256a,zeros(1,256));
iptest256a = horzcat(zeros(258,1),iptest256a,zeros(258,1));

%scaling factors:
%factor_x = 399/255; factor_y = 399/255;    %scaling to 400x400
%factor_x = 99/255; factor_y = 99/255;       %scaling to 100x100
factor_x = 299/255; factor_y = 199/255;    %scaling to 300x200

%to calculte dx and dy later
x=0; y=0;
dx = 1; dy = 1;

%k and l used in indexing result image; b and a to calculate new values of x and y
k=1;l=1;
a=1;b=1;

for i = 1:(1/factor_x):256
    for j = 1:(1/factor_y):256 
        
        result(k,l) = (1-dy)*[(1-dx)*double(iptest256a(round(i),round(j)))+dx*double(iptest256a(round(i+1),round(j)))]...
                        + dy*[(1-dx)*double(iptest256a(round(i),round(j+1)))+dx*double(iptest256a(round(i+1),round(j+1)))];
        
        
        new_y = a*(1/factor_y);
        dy = new_y - y;
        y = new_y;
        a = a+1;
        
        l=l+1;
    end
    
    new_x = b*(1/factor_x);
    dx = new_x - x;
    x = new_x;
    b = b+1;
    
    l = 1;a = 1;dy = 1;        %resetting values of l,a and dy for next row of pixels
    
    k = k+1;            
end

figure(1);
%imshow(uint8(result));
ip_disp(uint8(result));
title('Result from the scaling');




