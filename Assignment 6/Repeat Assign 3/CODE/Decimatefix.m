function Xd = Decimatefix(xn,fc,fs,N,M,Q)

hd = lowpasfil(N,fc,fs);               %Calling Anti Aliasing filter 
hd = int16(hd.*(2^Q));
X =int16((conv(xn,hd)./(2^Q)));

k=length(X);
Xf=X(((N-1)/2)+1:(k-(N-1)/2));   
Xd=downsample(Xf,M);             % Downsampling

end
