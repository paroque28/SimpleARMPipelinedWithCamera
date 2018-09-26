module thinning (
		input  [31:0] top,
		input  [31:0] center,
		input  [31:0] bottom,
		output logic [31:0] result
		);

assign result[31] = center[31];
assign result[0] = center[0];
thinning_small 
   thi1  ( .top   (top[31:29])
       .bottom (bottom[31:29]) ,
      .center  (center[31:29])) ,
      .result  (result[30]) ,
       ); 
thinning_small 
   thi2  ( .top   (top[30:28])
       .bottom (bottom[30:28]) ,
      .center  (center[30:28])) ,
      .result  (result[29]) ,
       ); 
thinning_small 
   thi3  ( .top   (top[29:27])
       .bottom (bottom[29:27]) ,
      .center  (center[29:27])) ,
      .result  (result[28]) ,
       ); 
thinning_small 
   thi4  ( .top   (top[28:26])
       .bottom (bottom[28:26]) ,
      .center  (center[28:26])) ,
      .result  (result[27]) ,
       ); 
thinning_small 
   thi5  ( .top   (top[27:25])
       .bottom (bottom[27:25]) ,
      .center  (center[27:25])) ,
      .result  (result[26]) ,
       ); 
thinning_small 
   thi6  ( .top   (top[26:24])
       .bottom (bottom[26:24]) ,
      .center  (center[26:24])) ,
      .result  (result[25]) ,
       ); 
thinning_small 
   thi7  ( .top   (top[25:23])
       .bottom (bottom[25:23]) ,
      .center  (center[25:23])) ,
      .result  (result[24]) ,
       ); 
thinning_small 
   thi8  ( .top   (top[24:22])
       .bottom (bottom[24:22]) ,
      .center  (center[24:22])) ,
      .result  (result[23]) ,
       ); 
thinning_small 
   thi9  ( .top   (top[23:21])
       .bottom (bottom[23:21]) ,
      .center  (center[23:21])) ,
      .result  (result[22]) ,
       ); 
thinning_small 
   thi10  ( .top   (top[22:20])
       .bottom (bottom[22:20]) ,
      .center  (center[22:20])) ,
      .result  (result[21]) ,
       ); 
thinning_small 
   thi11  ( .top   (top[21:19])
       .bottom (bottom[21:19]) ,
      .center  (center[21:19])) ,
      .result  (result[20]) ,
       ); 
thinning_small 
   thi12  ( .top   (top[20:18])
       .bottom (bottom[20:18]) ,
      .center  (center[20:18])) ,
      .result  (result[19]) ,
       ); 
thinning_small 
   thi13  ( .top   (top[19:17])
       .bottom (bottom[19:17]) ,
      .center  (center[19:17])) ,
      .result  (result[18]) ,
       ); 
thinning_small 
   thi14  ( .top   (top[18:16])
       .bottom (bottom[18:16]) ,
      .center  (center[18:16])) ,
      .result  (result[17]) ,
       ); 
thinning_small 
   thi15  ( .top   (top[17:15])
       .bottom (bottom[17:15]) ,
      .center  (center[17:15])) ,
      .result  (result[16]) ,
       ); 
thinning_small 
   thi16  ( .top   (top[16:14])
       .bottom (bottom[16:14]) ,
      .center  (center[16:14])) ,
      .result  (result[15]) ,
       ); 
thinning_small 
   thi17  ( .top   (top[15:13])
       .bottom (bottom[15:13]) ,
      .center  (center[15:13])) ,
      .result  (result[14]) ,
       ); 
thinning_small 
   thi18  ( .top   (top[14:12])
       .bottom (bottom[14:12]) ,
      .center  (center[14:12])) ,
      .result  (result[13]) ,
       ); 
thinning_small 
   thi19  ( .top   (top[13:11])
       .bottom (bottom[13:11]) ,
      .center  (center[13:11])) ,
      .result  (result[12]) ,
       ); 
thinning_small 
   thi20  ( .top   (top[12:10])
       .bottom (bottom[12:10]) ,
      .center  (center[12:10])) ,
      .result  (result[11]) ,
       ); 
thinning_small 
   thi21  ( .top   (top[11:9])
       .bottom (bottom[11:9]) ,
      .center  (center[11:9])) ,
      .result  (result[10]) ,
       ); 
thinning_small 
   thi22  ( .top   (top[10:8])
       .bottom (bottom[10:8]) ,
      .center  (center[10:8])) ,
      .result  (result[9]) ,
       ); 
thinning_small 
   thi23  ( .top   (top[9:7])
       .bottom (bottom[9:7]) ,
      .center  (center[9:7])) ,
      .result  (result[8]) ,
       ); 
thinning_small 
   thi24  ( .top   (top[8:6])
       .bottom (bottom[8:6]) ,
      .center  (center[8:6])) ,
      .result  (result[7]) ,
       ); 
thinning_small 
   thi25  ( .top   (top[7:5])
       .bottom (bottom[7:5]) ,
      .center  (center[7:5])) ,
      .result  (result[6]) ,
       ); 
thinning_small 
   thi26  ( .top   (top[6:4])
       .bottom (bottom[6:4]) ,
      .center  (center[6:4])) ,
      .result  (result[5]) ,
       ); 
thinning_small 
   thi27  ( .top   (top[5:3])
       .bottom (bottom[5:3]) ,
      .center  (center[5:3])) ,
      .result  (result[4]) ,
       ); 
thinning_small 
   thi28  ( .top   (top[4:2])
       .bottom (bottom[4:2]) ,
      .center  (center[4:2])) ,
      .result  (result[3]) ,
       ); 
thinning_small 
   thi29  ( .top   (top[3:1])
       .bottom (bottom[3:1]) ,
      .center  (center[3:1])) ,
      .result  (result[2]) ,
       ); 
thinning_small 
   thi30  ( .top   (top[2:0])
       .bottom (bottom[2:0]) ,
      .center  (center[2:0])) ,
      .result  (result[1]) ,
       ); 


	


endmodule;