`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     ALU
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//SET OF INSTRUCTIONS PERFORMED BY ALU
`define AND 	4'b0000
`define ADD 	4'b0010
`define OR  	4'b0001
`define SUB 	4'b0110
`define SLT 	4'b0111
`define NOR	4'b1100
`define XOR	4'b1101
//////////////////////////////////////ARITHMETIC LOGIC UNIT///////////////////////////////////////
module MIPS_ALU(
	input   [31:0] ReadData1,
	input   [31:0] ReadData2,	
	input 	[3:0] ALUCT,
	output	reg [31:0] ALUResult
);
	always @(ReadData1, ReadData2,ALUCT)
	begin
		
		case(ALUCT)
			`AND: ALUResult = ReadData1 & ReadData2;  		        //AND OPERATION
			`OR:  ALUResult = ReadData1 | ReadData2; 		       //OR OPERATION
			`ADD: ALUResult = ReadData1 + ReadData2;  		      //ADD OPERATION
			`SUB: ALUResult = ReadData1 - ReadData2; 		    // SUB OPERATION
			`SLT: ALUResult = $signed(ReadData1) < $signed(ReadData2);  // SET IF LESS THAN
			`NOR: ALUResult = ~(ReadData1 | ReadData2);		 	// NOR OPERATION
			`XOR: ALUResult = (ReadData1 ^ ReadData2);		 // XOR OPERATION
		endcase
	end
	
	
	

endmodule
