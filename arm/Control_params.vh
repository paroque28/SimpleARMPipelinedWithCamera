localparam FNOP	      = 4'b0000;
localparam FMULT	  = 4'b0001;
localparam FSUB	      = 4'b0010;
localparam FADD	      = 4'b0100;
localparam FSL	      = 4'b0110;
localparam FSR	      = 4'b0111;
localparam FPIC	      = 4'b1001;
localparam FAVERAGE	  = 4'b1010;
localparam FLDA	      = 4'b1011;
localparam FORR	      = 4'b1100;
localparam FTHI       = 4'b1111;



localparam OPDATA       = 2'b00;
localparam OPMEMORY     = 2'b01;
localparam OPBRANCH     = 2'b10;
localparam OPINTER      = 2'b11; // Interrupciones
