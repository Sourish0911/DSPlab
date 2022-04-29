[d,r] = audioread('msmn1.wav');

%% Decimate/Interpolate the sound file acoording to M, L 

M = 2;
L = 2;
fc = r / (2*M);
deciOut = Decim(M, fc, r, 101, d);
%audiowrite('decimated_output.wav',deciOut, round(r/M));
df = Inter(L, fc, r, 101, deciOut);
soundsc(df,r);
audiowrite('interpolated_output.wav',df, r);

%% Analyzing output

subplot(3,1,1);
specgram(d,1024,r);
title('Original Spectrogram')
subplot(3,1,2);
specgram(deciOut,1024,r/M);
title('Decimated Spectrogram')
subplot(3,1,3);
specgram(df,1024,r);
title('Decimated Interpolated Spectrogram')
