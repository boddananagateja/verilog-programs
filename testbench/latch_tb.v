`timescale 1ns/1ps
module tb_shift_register;
    reg clk;
    reg rst;
    reg en;
    reg mode;
    reg din;
    wire [3:0] q;
    // Instantiate DUT
    shift_register uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .mode(mode),
        .din(din),
        .q(q)
    );
    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("shift_register.vcd");
        $dumpvars;
        $monitor("T=%0t | clk=%b | mode=%b | din=%b | q=%b",$time, clk, mode, din, q);

        // Initialize signals
        clk = 0;
        rst = 1;
        en  = 0;
        mode= 0;
        din = 0;
        // Reset
        #20 rst = 0;
        en = 1;
        // LEFT SHIFT 
        mode = 0;
        din = 1;  #10;
        din = 0;  #10;
        din = 1;  #10;
        din = 1;  #10;
        // RIGHT SHIFT
        mode = 1;
        din = 0;  #10;
        din = 1;  #10;
        din = 0;  #10;
        din = 1;  #10;
        #50 $stop;
    end
endmodule
