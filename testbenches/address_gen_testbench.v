`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 01:18:10 AM
// Design Name: 
// Module Name: address_gen_testbench
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


module address_gen_testbench;

wire [31:0] pc;
reg [31:0] PCNext;
reg clk,rst;

address_gen uut2(.pc(pc),.PCNext(PCNext),.clk(clk),.rst(rst));

always begin
clk=0;
forever #30 clk=~clk;
end

initial begin
PCNext=32'h0;
#30
PCNext=32'h4;
#30
PCNext=32'h8;
end


endmodule
