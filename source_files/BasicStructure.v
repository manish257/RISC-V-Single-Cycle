`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:49:01 01/10/2021 
// Design Name: 
// Module Name:    Basic RISC-V single cycle implementation on Verilog 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module main(rst, clk, alu_z, Anode_Activate, LED_out);
input rst, clk;						// 1 button to reset, clock signal as input
output alu_z;						// An LED turned ON if result is zero
output reg[7:0] Anode_Activate;		// Anodes to control 7-segments
output reg [6:0] LED_out;			// output result to be sent on 7-segments
wire [31:0] pc;

wire [31:0] Result;
	// ALL modules will be called in this file. Code will be executed and results will be shown on 7-segment display
// Code segment for BCD to 7-segment Decoder. Keep this code as it is
reg [31:0] counter;		// A 32 bit flashing counter
reg toggle = 0;			// A variable to toggle between two 7-segments 

always @(posedge clk)
    begin
            if(counter>=100000) begin
                 counter <= 0;
				 toggle = ~toggle; end
            else begin
                counter <= counter + 1;
				end
    end 
    // anode activating signals for 8 segments, digit period of 1ms
    // decoder to generate anode signals 
    always @(*)
    begin
        case(toggle)
        1'b0: begin
            Anode_Activate = 8'b01111111; 
            // activate SEGMENT1 and Deactivate all others
              end
        1'b1: begin
            Anode_Activate = 8'b10111111; 
            // activate LED2 and Deactivate all others    
               end
        endcase
    end
    // Cathode patterns of the 7-segment 1 LED display 
    wire [31:0]hardwire;
    assign Result= hardwire;
    
    always @(*)
    begin
	if (toggle) begin
        case(Result)				// First 4 bits of Result from ALU will be displayed on 1st segment
        32'b0000: LED_out = 7'b0000001; // "0"     
        32'b0001: LED_out = 7'b1001111; // "1" 
        32'b0010: LED_out = 7'b0010010; // "2" 
        32'b0011: LED_out = 7'b0000110; // "3" 
        32'b0100: LED_out = 7'b1001100; // "4" 
        32'b0101: LED_out = 7'b0100100; // "5" 
        32'b0110: LED_out = 7'b0100000; // "6" 
        32'b0111: LED_out = 7'b0001111; // "7" 
        32'b1000: LED_out = 7'b0000000; // "8"     
        32'b1001: LED_out = 7'b0000100; // "9"
		32'b1010: LED_out = 7'b0001000; // "A"     
        32'b1011: LED_out = 7'b1100000; // "b"     
        32'b1100: LED_out = 7'b0110001; // "C"     
        32'b1101: LED_out = 7'b1000010; // "d"     
        32'b1110: LED_out = 7'b0110000; // "E"     
        32'b1111: LED_out = 7'b0111000; // "F"     
        
        default: LED_out = 7'b0000001; // "0"
        endcase
		end
    

	// Cathode patterns of the 7-segment 2 LED display
if(!toggle) begin	
        case(Result[7:4])			// Next 4 bits of Result from ALU will be displayed on 2nd segment
        4'b0000: LED_out = 7'b0000001; // "0"     
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5" 
        4'b0110: LED_out = 7'b0100000; // "6" 
        4'b0111: LED_out = 7'b0001111; // "7" 
        4'b1000: LED_out = 7'b0000000; // "8"     
        4'b1001: LED_out = 7'b0000100; // "9"
		4'b1010: LED_out = 7'b0001000; // "A"     
        4'b1011: LED_out = 7'b1100000; // "b"     
        4'b1100: LED_out = 7'b0110001; // "C"     
        4'b1101: LED_out = 7'b1000010; // "d"     
        4'b1110: LED_out = 7'b0110000; // "E"     
        4'b1111: LED_out = 7'b0111000; // "F"     
        
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
end
    
    
	// Keep writing your code (calling lower module) here!
	wire [31:0] PCNext,PCPlus4,PCTarget,immext;
	wire [6:0] opcode;
	wire [2:0] func3;
	wire [6:0] func7;
    wire PCSrc, MemWrite, ALUSrc, RegWrite, Btype,ZeroOut, CarryOut;
    wire ResultSrc;
    wire [3:0] ALUControl;
    wire [1:0]  immsrc;
    wire [31:0] Port_A, Port_B; 
    wire [31:0] Din; 
    wire [4:0] Addr_A, Addr_B, Addr_Wr; 
    wire wr, clk, rst; 
    wire [31:0] RESULT;
    wire [31:0] A,B;
    wire [3:0] ALU_Sel;
    wire [31:0] ALU_Out;
    wire [31:0] Data_Out;
    wire [31:0] Data_In;
    wire [31:0] D_Addr;
    wire [31:0] instruction;
    
	adder pcplus4ins(.a(pc),.b(32'h4),.y(PCPlus4));
	
	adder pctargetins(.a(pc),.b(immext),.y(PCTarget));
	
	mux2x1 pcmux(.sel(PCSrc),.b(PCPlus4),.a(PCTarget),.o(PCNext));
	
	instruction_memory instructionmemory(.pc(pc),.instruction(instruction));
	
	
	mux2x1 middle(.sel(ALUSrc),.b(Port_B),.a(immext),.o(B));
	
	Control_Unit controller(.opcode(instruction[6:0]) , .func3(instruction[14:12]) , .func7(instruction[31:25]), .ZeroOut(ZeroOut), .CarryOut(CarryOut),
                        .PCSrc(PCSrc), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite),
                        .ALUControl(ALUControl),
                        .ImmSrc(immsrc));
                        
     extend ext(.instruction(instruction[31:7]), .immsrc(immsrc), .immext(immext));
     
     register_file registerfile(.Port_A(Port_A), .Port_B(Port_B),.hardwire(hardwire), .RESULT(RESULT), .Addr_A(instruction[19:15]), .Addr_B(instruction[24:20]), .Addr_Wr(instruction[11:7]), .wr(RegWrite), .clk(clk),.rst(rst));
     
     alu alu( .A(Port_A),.B(B),.ALU_Sel(ALUControl),.ALU_Out(ALU_Out),.CarryOut(CarryOut), .ZeroOut(ZeroOut));
     
     address_gen AddressGenerator(.pc(pc),.PCNext(PCNext),.clk(clk),.rst(rst));
     
     mux2x1 muxatend(.o(RESULT),.b(ALU_Out),.a(Data_Out),.sel(ResultSrc));
    // mux3 muxatend( .a(ALU_Out),.b(Data_Out),.c(PCPlus4), .sel(ResultSrc),.y(RESULT));
     Data_Memory datamemory(.Data_Out(Data_Out),.Data_In(Port_B),.D_Addr(ALU_Out), .wr(MemWrite), .rst(rst),.clk(clk));
     
endmodule







module Control_Unit(input [6:0] opcode , input [2:0] func3 , input [6:0] func7,input ZeroOut,input CarryOut,
					output reg PCSrc, MemWrite, ALUSrc, RegWrite,
					output reg [3:0] ALUControl,
					output reg  ResultSrc,
					output [1:0] ImmSrc,
					output reg [2:0] instruction_type);			
	// This is the part of Phase-II
	
	always @ (*)
	begin
	case (opcode)
	7'b0010011: instruction_type = 3'd0; //i-type
	7'b1100111: instruction_type = 3'd0; //i-type jalr
	7'b0000011: instruction_type = 3'd0; //lw i-type
	7'b0100011: instruction_type = 3'd1; //sw s-type
	7'b1100011: instruction_type = 3'd2; //b-type
	7'b1101111: instruction_type = 3'd3; //j-type jal
	7'b0110011: instruction_type = 3'd4; //r-type
	7'b0110111: instruction_type = 3'd5; //u-type lui
	7'b0010111: instruction_type = 3'd5; //u-type auipc
	default: instruction_type = 3'd0; 
	endcase
	end
	assign ImmSrc = instruction_type[1:0];
	always @(*)
	begin
	if (instruction_type == 0 || instruction_type == 3'd4 || instruction_type == 3'd5 || instruction_type == 3'd3)
        RegWrite=1;
     else
        RegWrite =0;
            
    if (instruction_type==1)
        MemWrite=1;
    else
        MemWrite=0;
        
    if(opcode == 7'b0000011)
        ResultSrc = 1;
//    if (instruction_type==3'd3 || opcode == 7'b1100111)
//        ResultSrc =2'b10;    
    else
        ResultSrc =0;
        
    if ( instruction_type== 3'd2 || instruction_type == 3'd4)
        ALUSrc = 0;
    else
        ALUSrc =1;
    end
	
	always @(*)
    begin
        casex({opcode,func3,func7})
        17'b01100110000000000: ALUControl = 4'b0000; //add 
        17'b01100110000100000: ALUControl = 4'b0001; //sub
        17'b01100110000000001: ALUControl = 4'b0010; //mul
        17'b01100111000000001: ALUControl = 4'b0011; //div
        17'b0010011000xxxxxxx: ALUControl = 4'b0000;   //addI 
        17'b1100011000xxxxxxx: ALUControl = 4'b0001;       //beq
        17'b1100011001xxxxxxx: ALUControl = 4'b0001;       //bneq
        17'b1100011100xxxxxxx: ALUControl = 4'b0001; //blt
            
        endcase
    end
        
    always @(*)
        begin
            casex({opcode,func3})
                10'b1101111xxx, 10'b1100111xxx: PCSrc = 1;   //J type instruction
                10'b1100011000: PCSrc = ZeroOut; //BEQ
                10'b1100011001: PCSrc = ~ZeroOut; //BNE
                10'b1100011101, 10'b1100011111 : PCSrc = (~CarryOut) || ZeroOut; //BGE
                10'b1100011100, 10'b1100011111: PCSrc =CarryOut;
                default: PCSrc=0;
            endcase
        end
	
endmodule

module mux2x1(output [31:0]o,		// 32 bit output
					input[31:0]a,b,		// 32 bit inputs
					input sel			// Selection Signal
			);
			
	assign o = sel ? a:b;
endmodule


