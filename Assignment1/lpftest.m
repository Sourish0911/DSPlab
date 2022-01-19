function hd = lpftest(N,wc)
range = -(N-1)/2:1:(N-1)/2;
    if range(n) ~= 0
        hd = (sin(wc*range(n)))/(pi*range(n));
    else
        hd = wc/pi;
    end
end