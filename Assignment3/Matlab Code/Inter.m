function xu = Inter(L,fc,fs,N,x)

%Output of Upsample from filter o/p
upsampled_out = upsample(x,L);

%Creating a filter by calling the filter function
fil = lowpasfil(N,fc,fs);

%Creating Window by calling the window function
w = win(N);

%Creating the Anti Aliasing Filter
Anti_Image_fil = fil.*w;

%Output of Anti Imaging Filter with gain L
Op_Anti_Image_fil = L.*conv(Anti_Image_fil,upsampled_out);

k = length(Op_Anti_Image_fil);

%Update the Number of samples since the comvolution will
xu=Op_Anti_Image_fil(((N-1)/2)+1:(k-(N-1)/2));
    

end