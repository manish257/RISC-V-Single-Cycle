`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 12:22:43 AM
// Design Name: 
// Module Name: mux2x1_testbench
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


module mux2x1_testbench;

wire [31:0]o;
reg[31:0]a,b;
reg sel;

mux2x1 uut(.o(o),.a(a),.b(b),.sel(sel));
initial begin
a=0;
b=1;
sel=1;
end

endmodule
