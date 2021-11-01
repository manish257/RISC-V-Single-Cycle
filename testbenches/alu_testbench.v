`timescale 1ns / 1ps


module alu_testbench;
reg [31:0] A,B;  // ALU 8-bit Inputs
reg [3:0] ALU_Sel;// ALU Selection
wire [31:0] ALU_Out; // ALU 8-bit Output
wire CarryOut; // Carry Out Flag
wire ZeroOut;	// Zero Flag

alu uut(
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .ALU_Out(ALU_Out),
    .CarryOut(CarryOut),
    .ZeroOut(ZeroOut)
);

//initial
//begin
//clk = 0;
//forever #10 clk = ~clk;
//end

initial begin
    A = 0;
    B = 0;
    ALU_Sel= 0;
    
    #10;
    
    A = 2;
    B = 2;
    ALU_Sel = 4'b0001;

end

endmodule
