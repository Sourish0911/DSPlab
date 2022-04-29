


[x,fs] = audioread('msmn1.wav');

%% Decimate/Interpolate the sound file acoording to M, L 

M=input('Enter Scaling factor for Decimation and Interpolation =');
fc = fs / (2*M);
N=101;

%audiowrite('decimated_output.wav',deciOut, round(r/M));

% soundsc(df,r);
%audiowrite('interpolated_output.wav',df, r);


%%

xd=Decim(M,fc,fs,N,x);                                   % Calling Decimation function

Yn = Inter(M,fc,fs,N,xd);                             % Calling Interpolation function

en = Yn-x;                                                  % Calculating Error
abs_en=abs(en);
mean_error = mean(abs_en);                                   % Averaging Error

%%
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


%% Analyzing output

subplot(3,1,1);
specgram(x,1024,fs);
title('Original Spectrogram')
subplot(3,1,2);
specgram(Yn,1024,fs/M);
title('Interpolated Spectrogram Floating Point')
subplot(3,1,3);
specgram(Yn_fix,1024,fs);
title('Interpolated Spectrogram Fixed Point')
