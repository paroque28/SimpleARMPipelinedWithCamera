module memSelect(input address,
				output logic [3:0] mem_select
);

parameter limitA = 5'h40000;
parameter limitB = 5'h0000;
parameter limitC = 5'h0000;
parameter limitD = 5'h0000;

always_comb
begin
if (address >= limitA && address < limitB)
	begin
		mem_select = 4'b0001;
	end
else
	begin
		if (address < limitA)
			begin
				mem_select = 4'b1000;
			end
		else 
			begin
				if (address >= limitB && address < limitC)
					begin
					mem_select = 4'b0010;
					end
				else
					begin
						mem_select = 4'b0100;
					end
			end
	end
end

endmodule
