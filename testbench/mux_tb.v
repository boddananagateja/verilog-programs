`timescale 1ns/1ps

module muxtest;

    //testbench signals
    reg [15:0] in;
    reg [3:0] sel;
    wire out;

    // Instantiate DUT (Device Under Test)
	  mux16x1 uut (
        .in(in),
        .sel(sel),
        .out(out)
    );
    integer i;   // loop variable

    // Apply test patterns
    initial begin
       $dumpfile("mux16x1.vcd");
       $dumpvars(0,muxtest);
       $monitor("Time=%0t ns | sel=%b (%0d) | out=%b", $time, sel, sel, out);
        // Initialize inputs
        in = 16'b1010101111000001; //16 bit binary input
        sel = 4'b0000;
		// Test different select values
        for (i = 0; i < 16; i = i + 1) begin
            sel = i[3:0];   // assign loop value to sel
            #10;
        end
        $finish;
          
    end

endmodule
