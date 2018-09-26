module thinning (
		input  [31:0] top,
		input  [31:0] center,
		input  [31:0] bottom,
		output logic [31:0] result
		);

assign result[31] = center[31];
assign result[0] = center[0];

genvar i;
generate
    for (i=1; i<=30; i=i+1) begin : thin_blocks
    thinning_small thi  ( 
	   .top   	(top[i+1:i-1]),
      .bottom 	(bottom[i+1:i-1]) ,
      .center  (center[i+1:i-1]) ,
      .result  (result[i])
       );
	end 
endgenerate

	
endmodule