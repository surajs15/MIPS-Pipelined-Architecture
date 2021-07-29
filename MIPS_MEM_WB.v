`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     MEM/WB REGISTER
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//////////////////////////////////////MEM_WB REGISTER//////////////////////////////////////////////
module MIPS_MEM_WB(
	input   CLK,			//INPUT CLOCK
	input 	MemtoregMEM,
	input 	RegWriteMEM,	
	input 	[31:0]ALUResultMEM,
	input 	[4:0]WriteRegMEM,
	input	[31:0]MemReadDataMEM,
	output	reg 	MemtoregWB,
	output	reg 	RegWriteWB,	
	output	reg 	[31:0]ALUResultWB,
	output	reg 	[4:0]WriteRegWB,
	output	reg	[31:0]MemReadDataWB
);
	//At ClockEdge Write the contents to MEM/WB Register
	always @(posedge CLK)
	begin
		MemtoregWB <= MemtoregMEM;
		RegWriteWB <= RegWriteMEM;
		ALUResultWB <= ALUResultMEM;
		WriteRegWB <= WriteRegMEM;
		MemReadDataWB <= MemReadDataMEM;
	end

	
endmodule
