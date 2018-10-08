module pc(
  input logic clk, reset,
  input logic enable,
  input logic [0:31] dirIn,
  output logic [0:31] dirOut
  );

logic [0:31] dir;

always_ff @ (posedge clk) begin
  if (enable && ~reset) begin
      dir <= dirIn;
  end
  else begin
    dir <= 0;
  end
end  

always_ff @(negedge clk) begin
  if (reset) begin
    dirOut <= 0;
  end
  else begin
    dirOut <= dir;
  end
end

endmodule
