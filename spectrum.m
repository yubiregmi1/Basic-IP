%Script to display spectrum of the image and perform frequency
%domain butterworth filtering.


clear all;
clc;

load iptest_im iptest256a;

[N,M] = size(iptest256a);

shifted_image = zeros(N,M);      %contains image after being multiplied by (-1)^(x+y)

%multiply image by (-1)^(x+y)
for i=1:N
    for j=1:M
        shifted_image(i,j) = ((-1)^(i+j))*double(iptest256a(i,j));
    end
end

%padding the image before taking fourier transform
shifted_image = horzcat(shifted_image,zeros(256,256));
shifted_image = vertcat(shifted_image,zeros(256,512));

%spectrum of the image
F = fft2(shifted_image,512,512);
figure(1);
ip_dispsc(log10(abs(F)+1));
title('Frequency Spectrum of the image');

%Calculation for filter
N_2 = 2*N; M_2 = 2*M;
mid_N = (N_2/2-1); mid_M = (M_2/2)-1;
n = 2;
D0 = 2*32;
H = zeros(N_2,M_2);
for i = 0:(N_2-1)
    for j = 0:(M_2-1)
        D = sqrt((i-mid_N)^2 + (j-mid_M)^2);
        H(i+1,j+1) = 1/(1+(D0/D))^(2*n);
    end
end

%Filtering
G = F.*H;
g = ifft2(G);

gg = real(g);
gg = gg(1:N,1:N); %cropping the image

%multiplication by (-1)^(x+y)
for i=1:N
    for j=1:M
        gg(i,j) = ((-1)^(i+j))*gg(i,j);
    end
end

figure(2);
ip_disp(uint8(gg));
title('Filtered image');