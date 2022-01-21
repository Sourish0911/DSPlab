 %Parameter list for the filter1
 fs1 = 1600;
 N1 = 39;
 fc1 = 400;
 
 %Calling the filter funtion for the filter1
 filter_1 = lowpasfil(N1,fc1,fs1);
 
 %Magnitude plot for the filter1
 fvtool(filter_1)
 
 %windowing on the filter1
 window_filter1 = filter_1.*win(N1);
 
 %Magnitude plot for post window operation
 fvtool(window_filter1)
 
  %Parameter list for the filter2
 fs2 = 3200;
 N2 = 39;
 fc2 = 400;
 
 %Calling the filter funtion for the filter2
 filter_2 = lowpasfil(N2,fc2,fs2);
 
 %Magnitude plot for the filter2
 fvtool(filter_2)
 
 %windowing on the filter2
 window_filter2 = filter_2.*win(N2);
 
 %Magnitude plot for post window operation
 fvtool(window_filter2)
