function h = finalFilter(fc, fs, N)
    w = window(1,N);
    hd = filter(fs, fc, N);
    h = hd.*w;
end

