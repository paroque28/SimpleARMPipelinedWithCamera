module pc(
  input logic clk,
  input logic enable,
  input logic [0:31] dirIn,
  output logic [0:31] dirOut
  );

logic [0:31] dir;

always_ff @ (posedge clk) begin
  if (enable) begin
      dir <= dirIn;
  end
end  

always_ff @(negedge clk) begin
  dirOut <= dir;
end

endmodule
