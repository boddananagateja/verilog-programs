`timescale 1ns / 1ps

module up_down_tb;

    // Inputs to DUT (Design Under Test)
    reg mode;
    reg clr;
    reg ld;
    reg clk;
    reg [0:7] d_in;

    // Outputs from DUT
    wire [0:7] count;

    // Instantiate the Device Under Test (DUT)
    up_down uut (
        .mode(mode),
        .clr(clr),
        .ld(ld),
        .clk(clk),
        .d_in(d_in),
        .count(count)
    );

    // Clock generation: 100MHz (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        mode = 1; // Default to Up
        clr = 0;
        ld = 0;
        d_in = 0;

        // Monitor outputs
        $monitor("Time=%0t | clr=%b | ld=%b | mode=%b | d_in=%d | count=%d", 
                 $time, clr, ld, mode, d_in, count);

        // --- Test Scenario ---
        
        // 1. Reset the counter
        #10 clr = 1;
        #10 clr = 0;
        
        // 2. Test Parallel Load
        #10 ld = 1; d_in = 8'd50;
        #10 ld = 0; // Turn off load
        
        // 3. Count UP
        mode = 1;
        repeat(5) @(posedge clk);
        
        // 4. Test Clear during count
        #10 clr = 1;
        #10 clr = 0;
        
        // 5. Count DOWN
        mode = 0;
        repeat(5) @(posedge clk);
        
        // 6. Load again and count down
        #10 ld = 1; d_in = 8'd10;
        #10 ld = 0;
        repeat(5) @(posedge clk);

        // End Simulation
        #20 $finish;
    end
      
endmodule
