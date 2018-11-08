%Script that applies unweighted 5x5 average mask

clc;
clear all;

load iptest_im iptest256a;

%padding two rows and columns of zeros at top, bottom and sides of the image
iptest256a = vertcat(zeros(2,256),iptest256a,zeros(2,256));
iptest256a = horzcat(zeros(260,2),iptest256a,zeros(260,2));

result = zeros(256,256);

%i and j used to iterate through padded image
for i = 3:258
    for j = 3:258
        
        %temp_res holds unweighted sum from mask
        temp_res = 0;
        
        %k and j used to apply 5x5 mask
        for k = -2:2
            for l = -2:2
                temp_res = temp_res + double(iptest256a(i+k,j+l));
            end
        end
        
        result(i-2,j-2) = temp_res/25;
        
    end
end

r = uint8(result);  %r contains result image
ip_disp(r);
title('Image after applying 5x5 averaging mask');