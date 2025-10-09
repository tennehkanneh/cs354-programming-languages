`timescale 1ns/100ps

module fibo#(BITS=32)();

    reg clk;
    reg [BITS-1:0]inp; // data read: ARD -> EPT
    reg [BITS-1:0]out;
// data writ: EPT -> ARD
    reg ie, oe;
// input/output enable

    Fibonacci#(.BITS(BITS))
        f(.CLK(clk),
        .INP(inp),      .IE(ie),
        .OUT(out),      .OE(oe));
always #7.5 clk=~clk;	    // create a 66Mhz clock (15ns period)

    integer i;
initial begin
        clk=1'b0;
// enabled
        // 0 1 1 2 3 5 8 13
      
        for (i=0; i<=10; i++) begin
	        ie=1;
            $display("\n=======================================================");
            $display("TIME=%0t | TESTBENCH: Starting Fibo(%0d) sequence.", $time, i);
            $display("=======================================================");
            
	        inp=i;			            // provide input
	        #30;
	        ie=0;
            $display("TIME=%0t | TESTBENCH: Input latched (IE=0), waiting for Fibo OE...", $time);
// input latched during ie
	        wait (oe);
// until output good
	        $display("TIME=%0t | TESTBENCH: **RESULT** fibo(%1d)=%1d", $time, inp,out);
        end
        $stop;
    end

// `include "monitor"

endmodule