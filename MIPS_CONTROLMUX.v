`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     CONTROL SIGNAL MUX
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
/////////////////////////////////////// CONTROL SIGNAL MUX/////////////////////////
module MIPS_CONTROLMUX (		
	input 	MemReadID,	
	input 	MemwriteID,
	input 	MemtoregID,
	input 	RegWriteID,	
	input 	RegDstID,
	input 	ALUsrcID,
	input 	[1:0]ALUOPID,
	input 	Stall,
	output	reg MemReadMID,	
	output	reg MemwriteMID,
	output	reg MemtoregMID,
	output	reg RegWriteMID,	
	output	reg RegDstMID,
	output	reg ALUsrcMID,
	output	reg [1:0]ALUOPMID
);
	//MUX USED TO INTRODUCE BUBBLE ON HAZARD DETECTION
	always @(MemReadID, MemwriteID, MemtoregID, RegWriteID, RegDstID, ALUsrcID, ALUOPID, Stall)
	begin
		//MAKE CONTROL SIGNALS = 0 IF STALL SIGNAL ==1
		case(Stall)
			0 : begin
				MemReadMID = MemReadID;
				MemwriteMID = MemwriteID;
				MemtoregMID = MemtoregID;
				RegWriteMID = RegWriteID;
				RegDstMID = RegDstID;
				ALUsrcMID = ALUsrcID;
				ALUOPMID = ALUOPID;
			    end
			1 : begin
				MemReadMID = 0;
				MemwriteMID = 0;
				MemtoregMID = 0;
				RegWriteMID = 0;
				RegDstMID = 0;
				ALUsrcMID = 0;
				ALUOPMID = 2'b0;
			    end
			default:begin
				MemReadMID = MemReadID;
				MemwriteMID = MemwriteID;
				MemtoregMID = MemtoregID;
				RegWriteMID = RegWriteID;
				RegDstMID = RegDstID;
				ALUsrcMID = ALUsrcID;
				ALUOPMID = ALUOPID;
			    end
		endcase
	end

	
endmodule
