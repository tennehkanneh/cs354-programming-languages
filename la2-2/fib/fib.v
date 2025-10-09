module Fibonacci#(BITS='d32)(
    input CLK,
    input      [BITS-1:0]INP,       input       IE,
    output reg [BITS-1:0]OUT,       output reg OE);

    wire [BITS-1:0] A_out, B_out, mux_out, sum, ctr_out;
    wire a_oe, B_oe, mux_oe, add_oe, ctr_init, ctr_oe;

    localparam false=1'b0;
    localparam true=1'b1;

    localparam zero=BITS'(0);
    localparam one=BITS'(1);

  
    Store#(.BITS(BITS), .FIRST(zero)) 
        a(  .CLK,
	        .INP(B_out),    
            .OUT(A_out),
	        .IE(ctr_oe),      
            .OE(A_oe),
	        .INIT(ctr_init)
        );	                    

    Store#(.BITS(BITS), .FIRST(one))
        b(  .CLK,
	        .INP(sum),          
            .OUT(B_out),
	        .IE(ctr_oe),        
            .OE(B_oe),
	        .INIT(ctr_init));	                    

    Counter#(.BITS(BITS))
        ctr(    .CLK,
	            .INP(INP),          
                .IE(IE),
	            .OUT(ctr_out),      
                .OE(ctr_oe),
                .DECR(true),		                
                .STOP(one),		                   
	            .CE(add_oe), 
	            .INIT(ctr_init), 
                .DONE(OE)
        );

    Add#(.BITS(BITS))
       add( .CLK,
	        .A(A_out),      
            .B(B_out),
	        .IEA(A_oe), 
            .IEB(B_oe),
	        .Y(sum),  
            .OE(add_oe));

assign OUT = B_out;

endmodule