
function y = Decim(M, fc, fs, N, x)
    h = finalFilter(fc, fs, N);
    hlen = length(h);
    xlen = length(x);
    xf = conv(x, h);
    xf = xf((hlen-1)/2+1 : (hlen-1)/2+xlen);
    y = downsample(xf, M);
end