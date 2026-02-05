`timescale 1ns/1ps
module shift_register (
    input clk,
    input rst,
    input en,
    input mode,        // 0 = left, 1 = right
    input din,
    output reg [3:0] q
);
    always @(posedge clk) begin
      if (rst)
            q <= 4'b0000;
        else if (en) begin
          if (mode == 1'b0) begin
            q <= {q[2:0], din};  // LEFT shift
          end
            else begin
              q <= {din, q[3:1]};   // RIGHT shift
            end
        end
    end
endmodule
