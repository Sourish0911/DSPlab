 fs = 16000;
 N = 4;
 fc = fs/6;
 wc = 2*pi*fc;
 ws = 2*pi*fs;
 range = -(N-1)/2:1:(N-1)/2;
 
 hd = zeros(1,N);
for n = 1:length(range)
hd(n) = lpftest(N,wc);
end

fvtool(hd);
