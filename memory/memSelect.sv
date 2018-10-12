module memSelect(input [31:0] address,
				output logic [1:0] mem_select
);

parameter limitA = 'h60000;
parameter limitB = 'h60004;
parameter limitC = 'h60008;
parameter limitD = 'h80000;

always_comb
	if (address >= limitD) mem_select = 2'bzz;
	else if (address >= limitC) mem_select = 2'b11;
	else if (address >= limitB) mem_select = 2'b10;
	else if (address >= limitA) mem_select = 2'b01;
	else  mem_select = 2'b00;
endmodule
