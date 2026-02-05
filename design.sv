
`timescale 1ns / 1ps
module mux16x1(
    input [15:0] in,
    input [3:0] sel,
    output out
    );

assign out = in[sel];
endmodule