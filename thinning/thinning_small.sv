module thinning_small(
		input  [2:0] top,
		input  [2:0] center,
		input  [2:0] bottom,
		output logic [0] result
		);

logic [3:0] A;
logic [3:0] B;
logic [7:0] vecinos;
logic [8:0] vecinos_cadena;
logic [2:0] P2P4P6white;
logic [2:0] P4P6P8white;
logic [2:0] P2P4P8white;
logic [2:0] P2P6P8white;
logic step1;
logic step2;


assign vecinos = {top[1:0], center[0], bottom[0], bottom[1], bottom[2], center[2],top[2]};
assign vecinos_cadena = {top[1:0], center[0], bottom[0], bottom[1], bottom[2], center[2],top[2:1]}; // se repite top[1]

assign P2P4P6white = {top[1], center[2], bottom[1]} != 3'b111;
assign P4P6P8white = {center[2], bottom[1], center[0]} != 3'b111;
assign P2P4P8white = {top[1], center[2], center[0]} != 3'b111;
assign P2P6P8white = {top[1], bottom[1], center[0]} != 3'b111;

assign step1 = P2P4P6white && P4P6P8white;
assign step2 = P2P4P8white && P2P6P8white;

always_comb begin
	B = 0;  //initialize count variable.
   for(int i=0;i<8;i=i+1)   //for all the bits.
        B = B + vecinos[i]; //Add the bit to the count.
end

always_comb begin
	A = 0; 
   for(int i=0;i<8;i=i+1)
		  if(~vecinos_cadena[i])
				A = A + vecinos_cadena[i+1];
end

always_comb begin
	if(center[1])begin
		if(B<=6 && 2 <= B && A == 1 && (step1 || step2))begin
			result = 1'b0;	
		end else begin
			result = center[1];
		end
	end else begin
		result = center[1];
	end
end

endmodule