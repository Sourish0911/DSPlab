function hd = lowpasfil(N,fc,fs)
range = -(N-1)/2:1:(N-1)/2;
hd = zeros(1,N);
wc = (2*pi*fc)/fs;
 for n = 1:length(range)
    if range(n) ~= 0
        hd(n) = (sin(wc*range(n)))/(pi*range(n));
    else
        hd(n) = wc/pi;
    end
 end
end





