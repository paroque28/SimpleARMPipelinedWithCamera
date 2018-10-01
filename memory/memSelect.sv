module memSelect(input address,
				output logic [3:0] mem_select
);

parameter limitA = 5'h40000;
parameter limitB = 5'h60000;
parameter limitC = 5'h60004;
parameter limitD = 5'h8000;

always_comb
	if (address >= limitD) mem_select = 4'bzzzz;
	else if (address >= limitC) mem_select = 4'b1000;
	else if (address >= limitB) mem_select = 4'b0100;
	else if (address >= limitA) mem_select = 4'b0010;
	else  mem_select = 4'b0001;
endmodule
