module mem_controller_tb();

logic clk, we;
logic [31:0] a, in, out;
mem_controller DUT (    .clk(clk),
                        .address(a), .data_in(in),
                        .we(we),
                        .data_out(out));

initial begin
    
    a = 'h0;
    we = 0;
    in = 0;
    #2;
    a = 'h50000;
    we = 1;
    in = 16;
    #2;
    a = 'h50000;
    we = 0;
    in = 18;
    #2;
    a = 'h50000;
    we = 0;
    in = 20;
    #2;
    a = 'h80000;
    we = 1;
    in = 20;
    #2;
    a = 'h80000;
    we = 0;
    in = 10;
    #2;
end

always   #1  clk =  ! clk; 



endmodule