`timescale 1ns / 1ps
module simple_latch(
    input data,
    input load,
    output reg d_out
);

always @(*)
begin
    if (load)
        d_out = data;
	 else
        d_out = d_out;
   
end

endmodule
