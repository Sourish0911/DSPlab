

f0 = 100;
f1 = 200;
f2 = 300;
fs = 2400;
x = [];
%implement x[n]=sin(2?f0nfs)?+0.5sin(2?f1nfs)?+0.6sin(2?f2nfs)

for n = 1:96
    x(n) = sin((2*pi*f0*n)/fs)+0.5*sin((2*pi*f1*n)/fs)+0.6*sin((2*pi*f2*n)/fs);
end



%case M=L=2 and fc = 600
M1 = 2;
L1 = 2;
fc1 = 600;
fs = 2400;
N1 = 101;

% Use decimator function to create decimated signal
xd1 = Decim(M1,fc1,fs,N1,x);

% Use the Interpolation function to create the output signal
y1 = Inter(L1,fc1,fs,N1,xd1);

%Calculation of error between output and input
e1 = y1 - x;

%calculation of mean error
abs_en1=abs(e1);
mean_error1 = mean(abs_en1);

disp(mean_error1)


%case M=L=4 and fc = 300
M2 = 4;
L2 = 4;
fc2 = 300;
fs = 2400;
N2 = 101;
% Use decimator function to create decimated signal
xd2 = Decim(M2,fc2,fs,N2,x);

% Use the Interpolation function to create the output signal
y2 = Inter(L2,fc2,fs,N2,xd2);

%Calculation of error between outpit and input
e2 = y2 - x;

%calculation of mean error
abs_en2=abs(e2);

mean_error2 = mean(abs_en2);
disp(mean_error2)

%case M=L=8 and fc = 150

M3 = 8;
L3 = 8;
fc3 = 150;
fs = 2400;
N3 = 101;
% Use decimator function to create decimated signal
xd3 = Decim(M3,fc3,fs,N3,x);

% Use the Interpolation function to create the output signal
y3 = Inter(L3,fc3,fs,N3,xd3);

%Calculation of error between outpit and input
e3 = y3 - x;

%calculation of mean error
abs_en3=abs(e3);
mean_error3 = mean(abs_en3);

disp(mean_error3)

%Plotting starts here
subplot(4,1,1)
stem(x)
title('Input Signal x(n)');

% subplot(4,1,2)
% stem(xd1)
% title('Decimated Signal xd1(n) with M=2');
% 
% subplot(4,1,3)
% stem(y1)
% title('Interpolated output Signal y1(n) with L=2');
% 
% subplot(4,1,4)
% stem(e1)
% title('Error for the case of M=L=2');
% 
% subplot(4,1,2)
% stem(xd2)
% title('Decimated Signal xd2(n) with M=4');
% 
% subplot(4,1,3)
% stem(y2)
% title('Interpolated output Signal y2(n) with L=4');
% 
% subplot(4,1,4)
% stem(e2)
% title('Error for the case of M=L=4');

subplot(4,1,2)
stem(xd3)
title('Decimated Signal xd2(n) with M=8');

subplot(4,1,3)
stem(y3)
title('Interpolated output Signal y2(n) with L=8');

subplot(4,1,4)
stem(e3)
title('Error for the case of M=L=8');


