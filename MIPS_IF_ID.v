`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     IF/ID Register
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//////////////////////////////////////IF_ID REGISTER//////////////////////////////////////////////
module MIPS_IF_ID(
	input   CLK,			//INPUT CLOCK
	input 	[31:0] PCsum,		//PC + 4 INPUT from Adder
	input 	[31:0] Instruction,	//Instruction from Instruction Memory
	input 	IF_FLUSH,		//Instruction FLush signal
	input 	IF_IDWrite,		// IF/ID Write Signal
	output	reg [31:0] PCoutID,	//PC+4 OUT
	output	reg [31:0] InstructionID	//Instruction OUT
);
	//At ClockEdge Write the contents to IF/ID Register
	always @(posedge CLK)
	begin 
		if(IF_FLUSH ==1'b1)		//If IF_FLUSH == 1 then flush the instruction by making Instruction Out = 0 
		begin
			PCoutID <= PCsum;
			InstructionID <=32'b0;
		end		
		
		//Writing into IF/ID Register is done only when IF/ID Write is 1 else stall insert a bubble
		else if(IF_IDWrite ==1'b0)
		begin
			PCoutID <= PCsum;
			InstructionID <= InstructionID;
		end
		
		//Writing PCoutID and InstrcutionID if PCWrite != 0
		else begin
			PCoutID <= PCsum;
			InstructionID <=Instruction;
		end
	end

	
endmodule
