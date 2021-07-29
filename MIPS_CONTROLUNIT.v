`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     CONTROL UNIT
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//

//////////////////////////////////////CONTROL UNIT/////////////////////////////////////////////////////////////////
module MIPS_CONTROLUNIT(
	input   [5:0] Opcode,		// OPCODE FIELD INPUT
	output	reg MemReadID,		// MEMORY READ CONTROL SIGNAL
	output	reg MemwriteID,		//MEMORY WYRITE CONTROL SIGNAL
	output	reg MemtoregID,		//MEMORY TO REG CONTROL SIGNAL
	output	reg RegWriteID,		//REGISTER WRITE CONTROL SIGNAL
	output	reg RegDstID,		//REGISTER DESTINATION CONTROL SIGNAL
	output	reg ALUsrcID,		// ALU SOURCE CONTROL SIGNAL
	output	reg BranchID,		//BRANCH CONTROL SIGNAL
	output	reg [1:0] ALUOPID		//ALU OPERATION SIGNAL
);
	always @(Opcode)
	begin
		MemReadID = 1'b0;
		MemwriteID = 1'b0;
		MemtoregID = 1'b0;
		RegWriteID = 1'b0;
		RegDstID = 1'b0;
		ALUsrcID = 1'b0;
		BranchID = 1'b0;
		ALUOPID = 2'b00;
		
		// R-TYPE INSTRUCTIONS
		if(Opcode == 6'b0)
		begin
			//DEFAULT CONTROL SIGNALS FOR R-TYPE INSTRUCTIONS
			MemReadID = 1'b0;
			MemwriteID = 1'b0;
			MemtoregID = 1'b0;
			RegWriteID = 1'b1;
			RegDstID = 1'b1;
			ALUsrcID = 1'b0;
			BranchID = 1'b0;
			ALUOPID = 2'b10;
		end
		//LW INSTRUCTION
		else if(Opcode == 6'b100011)
		begin
			// CONTROL SIGNALS FOR LW INSTRUCTIONS
			MemReadID = 1'b1;
			MemwriteID = 1'b0;
			MemtoregID = 1'b1;
			RegWriteID = 1'b1;
			RegDstID = 1'b0;
			ALUsrcID = 1'b1;
			BranchID = 1'b0;
			ALUOPID = 2'b00;
			
		end
		//SW INSTRUCTION
		else if(Opcode == 6'b101011)
		begin
			// CONTROL SIGNALS FOR SW INSTRUCTIONS
			MemReadID = 1'b0;
			MemwriteID = 1'b1;
			MemtoregID = 1'b0;
			RegWriteID = 1'b0;
			RegDstID = 1'b0;
			ALUsrcID = 1'b1;
			BranchID = 1'b0;
			ALUOPID = 2'b00;
			
		end
		//BEQ INSTRUCTION
		else if(Opcode == 6'b000100)
		begin
			// CONTROL SIGNALS FOR BEQ INSTRUCTIONS
			MemReadID = 1'b0;
			MemwriteID = 1'b0;
			MemtoregID = 1'b0;
			RegWriteID = 1'b0;
			RegDstID = 1'b0;
			ALUsrcID = 1'b0;
			BranchID = 1'b1;
			ALUOPID = 2'b00;
			
		end
end
endmodule
