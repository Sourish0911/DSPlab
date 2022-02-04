function w = win(N)
range = 0:1:(N-1);
w=zeros(0,N);
for n = 1:length(range)
    w(n) = 0.54-0.46*cos((2*pi*range(n))/(N-1));
end
