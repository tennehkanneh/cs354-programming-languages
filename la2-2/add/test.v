`timescale 1ns/100ps

module test_add#(BITS=8)();
    reg clk;
    reg [BITS-1:0]a, b;
    wire [BITS-1:0] y;
    reg iea, ieb, oe;		            // input/output enable
    
    
    Add#(.BITS(BITS))
        m(.CLK(clk),
        .A(a),       .B(b),
        .IEA(iea),   .IEB(ieb),
        .Y(y),       .OE(oe));

    always #7.5 clk=~clk;	            // create a 66Mhz clock (15ns period)

    integer i;
    
    initial begin
        clk=1'b0;			                // enabled
        
        iea=0; ieb=0;
        for (i=0; i<=6; i++) begin
            a=i; b=i;	                    // provide input
        
            #30 iea=1; ieb=1;	            // an input is latched when its ie goes true
            #30 iea=0;		                // one ie can then go false
	        
            wait (oe);		                // until output good
	 
            $display("add(%1d,%1d)=%1d",a,b,y);
        
            #30 ieb=0;	                    // output good until both ie go false
	        wait (!oe);		                // until ready for more
        end
        $stop;
    end

//`include "monitor"

endmodule