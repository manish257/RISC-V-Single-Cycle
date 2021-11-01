`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 01:03:45 AM
// Design Name: 
// Module Name: instruction_memory_testbench
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


module instruction_memory_testbench;

reg[31:0] pc;
wire [31:0] instruction;

instruction_memory uut (.pc(pc),.instruction(instruction));

initial begin

pc =32'h0;
#100     
pc =32'h4;
#100     
//gcd    
pc =32'h8;
#100     
pc =32'hC;
#100
pc =32'h10;
#100
pc =32'h14;
#100
//less
pc =32'h18;
#100
pc =32'h1C;
#100
//stop
pc =32'h20;

end
endmodule
