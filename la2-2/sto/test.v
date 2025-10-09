`timescale 1ns/100ps

module test_store#(BITS=32)();
    reg clk;
    reg [BITS-1:0] inp;
    wire [BITS-1:0] out;
    reg ie, oe;		            // input/output enable
    
    
    Sto#(.BITS(BITS), .FIRST(0))
        m(.CLK(clk),
        .INP(inp),     .IE(ie),
        .OUT(out),     .OE(oe),
        .INIT(1'b0));

    always #7.5 clk=~clk;	            // create a 66Mhz clock (15ns period)

    integer i;
    
    initial begin
        clk=1'b0;			                // enabled
        
        ie=0;
        for (i=0; i<=6; i++) begin
            inp=i;  	                    // provide input
        
            #30 ie=1;      	                // an input is latched when its ie goes true
            #30 ie=0;		                // one ie can then go false
	        
            wait (oe);		                // until output good
	 
            $display("store(%1d)=%1d",inp,out);
        
	        wait (!oe);		                // until ready for more
        end
        $stop;
    end

//`include "monitor"

endmodule