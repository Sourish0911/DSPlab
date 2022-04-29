function xd = Decim(M,fc,fs,N,x)

%Creating a filter by calling the filter function
fil = lowpasfil(N,fc,fs);

%Creating Window by calling the window function
w = win(N);

%Creating the Anti Aliasing Filter
Anti_Alias_fil = fil.*w;

%Output of Anti Aliasing Filter
Op_Anti_Alias_fil = conv(Anti_Alias_fil,x);

k = length(Op_Anti_Alias_fil);

%Update the Number of samples since the comvolution will
Int_Downsample=Op_Anti_Alias_fil(((N-1)/2)+1:(k-(N-1)/2));
    
%Output of Downsample from filter o/p
xd = downsample(Int_Downsample,M);
end