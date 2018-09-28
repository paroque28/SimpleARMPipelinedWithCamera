module ALU_tb();


logic [31:0] A, B;
logic [3:0] ALU_control;
logic [3:0] ALU_flags;
logic [31:0] outputC = 0;


ALU dut(A, B, ALU_control,ALU_flags,outputC);



//assign ALU_control = 4'b0001;
//assign ALU_control = 4'b0010;
//assign ALU_control = 4'b0011;
//assign ALU_control = 4'b0100;
//assign ALU_control = 4'b0101;
//assign ALU_control = 4'b0110;
//assign ALU_control = 4'b0111;




initial begin
A = 4;
B = 6;
//outputC = 1;
ALU_control = 4'b0010;
ALU_flags = 4'b0000;
end

always_comb
begin
	case(ALU_control)
	
		4'b0000://Case buffer
		if(outputC==4 && ALU_flags == 4'b0000) 
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display("Simulation Succeeded");
			//$stop;
			
			end
		else
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display ("Simulation failed");
			//$stop;
			
			end
		
		4'b0001://Case sum
			if(outputC==6 && ALU_flags == 4'b0000) 
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display("Simulation Succeeded");
			//$stop;
			
			end
		else
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display ("Simulation failed");
			//$stop;
			
			end
		
		4'b0010://Case subs
			if(outputC==2 && ALU_flags == 4'b0000) 
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display("Simulation Succeeded");
			//$stop;
			
			end
		else
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display ("Simulation failed");
			//$stop;
			
			end
		4'b0011://Case multiply
			if(outputC==8 && ALU_flags == 4'b0000) 
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display("Simulation Succeeded");
			//$stop;
			
			end
		else
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display ("Simulation failed");
			//$stop;
			
			end
		4'b0100://Case divide
			if(outputC==2 && ALU_flags == 4'b0000) 
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display("Simulation Succeeded");
			//$stop;
			
			end
		else
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display ("Simulation failed");
			//$stop;
			
			end
		4'b0101://Case Shift Left
			if(outputC==16 && ALU_flags == 4'b0000) 
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display("Simulation Succeeded");
			//$stop;
			
			end
		else
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display ("Simulation failed");
			//$stop;
			
			end
		4'b0110://Case Shift Rigth
			if(outputC==1 && ALU_flags == 4'b0000) 
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display("Simulation Succeeded");
			//$stop;
			
			end
		else
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display ("Simulation failed");
			//$stop;
			
			end
		4'b0111://Case special add
			if(outputC==4 && ALU_flags == 4'b0000) 
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display("Simulation Succeeded");
			//$stop;
			
			end
		else
			begin
			$display("A:");
			$display (A);
			$display("B:");
			$display (B);
			$display("outputC:");
			$display (outputC);
			$display("ALU_control:");
			$display (ALU_control);
			$display("ALU_flags:");
			$display (ALU_flags);
			$display ("Simulation failed");
			//$stop;
			
			end	
		default:  $display ("default");
	/*		
		4'b0001://Case sum
			temp_result = inputA + inputB;
		4'b0010://Case substraction
			temp_result = inputA - inputB;
		4'b0011://Case multiply
			temp_result = inputA * inputB;
		4'b0100://Case divide
			temp_result = inputA/inputB;
		4'b0101://Case Shift Left
			temp_result = inputA<<inputB;
		4'b0110://Case shift Right
			temp_result = inputA>>inputB;
		4'b0111://Case special sum
	if(DataAdr===100 & WriteData ===7) 
		begin
		$display("Simulation Succeeded");
		$stop;
		end
	else if (DataAdr !== 96)
		begin
		$display ("Simulation failed");
		$stop;
		end
*/
	endcase
end	

endmodule
