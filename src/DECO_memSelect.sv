module DECO_memSelect(input logic [31:0] adress,
							output logic [3:0] mem_select
);

logic [31:0] limitA = 5'h40000;
logic [31:0] limitB = 5'h0000;
logic [31:0] limitC = 5'h0000;
logic [31:0] limitD = 5'h0000;

logic [3:0] temp_select;
always_latch
begin
if (adress >= limitA && adress < limitB)
	begin
		temp_select = 4'b0001;
	end
else
	begin
		if (adress < limitA)
			begin
				temp_select = 4'b1000;
			end
		else 
			begin
				if (adress >= limitB && adress < limitC)
					begin
					temp_select = 4'b0010;
					end
				else
					begin
						temp_select = 4'b0100;
					end
			end
	end
end

assign mem_select = temp_select;
endmodule
