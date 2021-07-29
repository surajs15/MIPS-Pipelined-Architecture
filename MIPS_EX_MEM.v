`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     EX/MEM REGISTER
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
////////////////////////////////////// EX_MEM REGISTER//////////////////////////////////////////////
module MIPS_EX_MEM(
	input   CLK,			//INPUT CLOCK
	input 	MemReadEX,	
	input 	MemwriteEX,
	input 	MemtoregEX,
	input 	RegWriteEX,	
	input 	[31:0]ALUResultEX,
	input 	[31:0]ALUinput2EX,
	input 	[4:0]WriteRegEX,
	input   [31:0] ReadData2EX,
	output	reg 	MemReadMEM,	
	output	reg 	MemwriteMEM,
	output	reg 	MemtoregMEM,
	output	reg 	RegWriteMEM,	
	output	reg 	[31:0]ALUResultMEM,
	output	reg 	[31:0]ALUinput2MEM,
	output	reg 	[4:0]WriteRegMEM,
	output	reg	[31:0]ReadData2MEM
);
	//At ClockEdge Write the contents to EX/MEM Register
	always @(posedge CLK)
	begin 
		MemReadMEM <= MemReadEX; 	
		MemwriteMEM <= MemwriteEX;
		MemtoregMEM <= MemtoregEX;
		RegWriteMEM <= RegWriteEX;
		ALUResultMEM <= ALUResultEX;
		ALUinput2MEM <= ALUinput2EX;
		WriteRegMEM <= WriteRegEX;
		ReadData2MEM <= ReadData2EX;
	end

	
endmodule
