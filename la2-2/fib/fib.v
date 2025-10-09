module Fibonacci#(BITS='d32)(
    input CLK,
    input      [BITS-1:0]INP,       input       IE,
    output reg [BITS-1:0]OUT,       output reg OE);

    wire [BITS-1:0] A_out, B_out, sum, ctr_out;
    wire a_oe, B_oe, add_oe, ctr_init, ctr_oe;

    localparam false=1'b0;
    localparam true=1'b1;

    localparam zero=BITS'(0);
    localparam one=BITS'(1);

    Sto#(.BITS(BITS), .FIRST(zero))
        a(.CLK,
	    .INP(B_out),    .OUT(A_out),
	    .IE(B_oe),      .OE(A_oe),
	    .INIT(ctr_init));	                    // 0-> ~store, 1-> store

    Sto#(.BITS(BITS), .FIRST(one))
        b(.CLK,
	    .INP(sum),    .OUT(B_out),
	    .IE(add_oe),      .OE(B_oe),
	    .INIT(ctr_init));	                    // 0-> ~store, 1-> store

    Counter#(.BITS(BITS))
        ctr(.CLK,
	    .INP(INP),     .IE(IE),
	    .OUT(ctr_out), .OE(ctr_oe),
        .DECR(true),		                // count down
        .STOP(one),		                    // for (OUT=INP; OUT>1; OUT--)
	    .CE(add_oe), 
	    .INIT(ctr_init), .DONE(OE));

    Add#(.BITS(BITS))
       add(.CLK,
	   .A(A_out),      .B(B_out),
	   .IEA(A_oe), .IEB(B_oe),
	   .Y(sum),  .OE(add_oe));

assign OUT = B_out;

endmodule