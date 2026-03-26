`timescale 1ns/1ps

module pipe_ex2 (
    output [15:0] Zout,
    input  [3:0]  rs1, rs2, rd, func,
    input  [7:0]  addr,
    input         clk1, clk2
);

    // Pipeline registers
    reg [15:0] L12_A, L12_B;
    reg [15:0] L23_Z, L34_Z;
    reg [3:0]  L12_rd, L12_func, L23_rd;
    reg [7:0]  L12_addr, L23_addr, L34_addr;

    // Register bank and memory
    reg [15:0] regbank [0:15];
    reg [15:0] mem     [0:255];

    assign Zout = L34_Z;
    // STAGE 1 : FETCH

    always @(posedge clk1)
    begin
        L12_A    <= #2 regbank[rs1];
        L12_B    <= #2 regbank[rs2];
        L12_rd   <= #2 rd;
        L12_func <= #2 func;
        L12_addr <= #2 addr;
    end

    // STAGE 2 : EXECUTE
    always @(negedge clk2)
    begin
        case (L12_func)
            0  : L23_Z <= #2 L12_A + L12_B;
            1  : L23_Z <= #2 L12_A - L12_B;
            2  : L23_Z <= #2 L12_A * L12_B;
            3  : L23_Z <= #2 L12_A;
            4  : L23_Z <= #2 L12_B;
            5  : L23_Z <= #2 (L12_A & L12_B);
            6  : L23_Z <= #2 (L12_A | L12_B);
            7  : L23_Z <= #2 (L12_A ^ L12_B);
            8  : L23_Z <= #2 (-L12_A);
            9  : L23_Z <= #2 (-L12_B);
            10 : L23_Z <= #2 (L12_A >> 1);
            11 : L23_Z <= #2 (L12_A << 1);
            default: L23_Z <= #2 16'hXXXX;
        endcase
        L23_rd   <= #2 L12_rd;
        L23_addr <= #2 L12_addr;
    end

    // STAGE 3 : WRITE BACK
    always @(posedge clk1)
    begin
        regbank[L23_rd] <= #2 L23_Z;
        L34_Z           <= #2 L23_Z;
        L34_addr        <= #2 L23_addr;
    end


    // STAGE 4 : MEMORY STORE
    always @(negedge clk2)
    begin
        mem[L34_addr] <= #2 L34_Z;
    end

endmodule
