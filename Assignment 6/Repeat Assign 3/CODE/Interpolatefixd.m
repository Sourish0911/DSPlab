
function Yn = Interpolatefixd(xd,fc,fs,N,L,Q)

up=upsample(xd,L);                          % UpSampling
hd = lowpasfil(N,fc,fs);                          % Anti Imaging Filter
scal=L.*hd;
scal = int16(scal.*(2^Q));
Yf=int16((conv(scal,up)./(2^Q)));
k=length(Yf);
Yn=Yf(((N-1)/2)+1:(k-(N-1)/2));
end