module memSelect(input [31:0] address,
				output logic [3:0] mem_select
);

parameter limitA = 'h40000;
parameter limitB = 'h60000;
parameter limitC = 'h60004;
parameter limitD = 'h80000;

always_comb
	if (address >= limitD) mem_select = 4'bzzzz;
	else if (address >= limitC) mem_select = 4'b1000;
	else if (address >= limitB) mem_select = 4'b0100;
	else if (address >= limitA) mem_select = 4'b0010;
	else  mem_select = 4'b0001;
endmodule
