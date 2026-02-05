`timescale 1ns / 1ps
module up_down(
    input mode,
    input clr,
    input ld,
    input clk,
    input [0:7] d_in,
    output [0:7] count
    );
	 always@(posedge clk)
if(ld) 
     count <= d_in;
else if(clr) 
    count <=0;
else if(mode) 
   count <= count + 1;
else 
    count <= count - 1;    

endmodule
