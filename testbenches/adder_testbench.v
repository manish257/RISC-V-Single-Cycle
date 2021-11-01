`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 01:36:08 AM
// Design Name: 
// Module Name: adder_testbench
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


module adder_testbench;

reg [31:0] a, b;
wire [31:0] y;

adder uut (.a(a), .b(b),.y(y));

initial begin
a=32'd1;
b=32'd2;

end

endmodule
