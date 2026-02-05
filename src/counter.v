`timescale 1ns / 1ps
module counter(
input clock,
input clear,
output reg[3:0] count);
initial count = 0; 
always @(posedge clock)
begin
if (clear)
count <=0;
else 
count <= count+1;
end
endmodule
