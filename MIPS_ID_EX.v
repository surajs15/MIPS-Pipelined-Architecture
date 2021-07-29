`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     ID/EX REGISTER
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//////////////////////////////////////ID_EX REGISTER//////////////////////////////////////////////
module MIPS_ID_EX(
	input   CLK,			//INPUT CLOCK
	input 	MemReadID,	
	input 	MemwriteID,
	input 	MemtoregID,
	input 	RegWriteID,	
	input 	RegDstID,
	input 	ALUsrcID,
	input 	[1:0]ALUOPID,
	input 	[31:0]ImmExtID,
	input 	[31:0]ReadData1,
	input 	[31:0]ReadData2,
	input 	[4:0]Rs,
	input 	[4:0]Rt,
	input 	[4:0]Rd,
	output	reg 	MemReadEX,	
	output	reg 	MemwriteEX,
	output	reg 	MemtoregEX,
	output	reg 	RegWriteEX,	
	output	reg 	RegDstEX,
	output	reg 	ALUsrcEX,
	output	reg 	[1:0]ALUOPEX,
	output	reg 	[31:0]ReadData1EX,
	output	reg 	[31:0]ReadData2EX,
	output	reg 	[31:0]ImmExtEX,
	output	reg 	[4:0]RsEX,
	output	reg 	[4:0]RtEX,
	output	reg 	[4:0]RdEX
);
	//At ClockEdge Write the contents to ID/EX Register
	always @(posedge CLK)
	begin 
		MemReadEX <= MemReadID; 	
		MemwriteEX <= MemwriteID;
		MemtoregEX <= MemtoregID;
		RegWriteEX <= RegWriteID;
		RegDstEX <= RegDstID;
		ALUsrcEX <= ALUsrcID;
		ALUOPEX <= ALUOPID;
		ReadData1EX <= ReadData1;
		ReadData2EX <= ReadData2;
		ImmExtEX <= ImmExtID;
		RsEX <= Rs;
		RtEX <= Rt;
		RdEX <= Rd;
	end

	
endmodule
