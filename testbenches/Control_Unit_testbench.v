`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 10:19:14 PM
// Design Name: 
// Module Name: Control_Unit_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control_Unit_testbench;
reg [6:0] opcode;
reg[2:0] func3;
reg [6:0]func7;
reg ZeroOut;
reg CarryOut;
wire PCSrc, MemWrite, ALUSrc, RegWrite;
wire ResultSrc;
wire [3:0] ALUControl;
wire [1:0] ImmSrc;
wire [2:0] instruction_type;

Control_Unit uut(.opcode(opcode) , .func3(func3) , .func7(func7),.ZeroOut(ZeroOut),.CarryOut(CarryOut),
                .PCSrc(PCSrc), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite),
					.ALUControl(ALUControl),
					.ImmSrc(ImmSrc),
					.instruction_type(instruction_type));		
					
initial begin

opcode = 7'b1100011;
func3 =  3'b000;
func7 =  7'b0000000;
ZeroOut = 0;
CarryOut = 1;

end

					
					
endmodule
