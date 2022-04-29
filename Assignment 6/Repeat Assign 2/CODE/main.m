
clear
N=101;                                                     % Initializing order of the filter as given in question
M=input('Enter Scaling factor for Decimation and Interpolation =');  % M = 2 or 4 or 8
fc=input('Enter cutoff frequency =');                                % fc = 600 or 300 or 150
                                                  
%Input Frequencies
n = 0:1:95;
f0 = 100;
f1 = 200;
f2 = 300;
fs = 2400; % Sampling Frequency

x = sin(2*pi*f0*n/fs) + 0.5*sin(2*pi*f1*n/fs) + 0.6*sin(2*pi*f2*n/fs);

xd=Decim(M,fc,fs,N,x);                                   % Calling Decimation function

Yn = Inter(M,fc,fs,N,xd);                             % Calling Interpolation function

en = Yn-x;                                                  % Calculating Error
abs_en=abs(en);
mean_error = mean(abs_en);                                   % Averaging Error

%------------------------------------fixed point-------------------------------------------------------%
Q=1:1:16;
 %converting the input matrix to fixed point with Q
%mat1=int16(mat1);  %taking only integer values of fixed point values
MSE = zeros(length(Q),1);

for q = 1:length(Q)
xd_1=int16(x.*pow2(q));
xd_fix=Decimatefix(xd_1,fc,fs,N,M,q); 
Yn_fix = Interpolatefixd(xd_fix,fc,fs,N,M,q);
Yn_fix = double(Yn_fix)./(2^q);
error = (Yn_fix-Yn);
MSE(q) = mean(error.^2);
end

q = 14;
xd_1=int16(x.*pow2(q));
xd_fix=Decimatefix(xd_1,fc,fs,N,M,q); 
Yn_fix = Interpolatefixd(xd_fix,fc,fs,N,M,q);
Yn_fix = double(Yn_fix)./(2^q);
error = (Yn_fix-Yn);
MSE(q) = mean(error.^2);

fprintf("%d",MSE);
subplot(3,2,1)
stem(x)
title('Input Signal')
subplot(3,2,2)
stem(xd_fix)
title('Decimated output')
subplot(3,2,3)
stem(Yn_fix)
title('Interpolated Output Fixed')
subplot(3,2,4)
stem(Yn)
title('Interpolated Output Float')
subplot(3,2,5)
stem(error)
title('Error')
subplot(3,2,6)
plot(Q,MSE)
title('MSE vs Q')