`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     HAZARD DETECTION UNIT
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////HAZARD DETECTION UNIT//////////////////////////////
module MIPS_HAZARD(
	input   MemReadEX,
	input   [4:0] RtEX,	
	input   [4:0] RsID,	
	input   [4:0] RtID,	
	output	reg PCWrite,
	output	reg IF_IDWrite,
	output	reg Stall
);
	// HAZARD DETECTION UNIT USED TO INTRODUCE STALL FOR LOAD-USE CASE HAZARD
	always @(MemReadEX, RtEX, RsID, RtID )
	begin
		if((MemReadEX ==1'b1) && ((RtEX == RsID) || (RtEX == RtID)) ) begin
			PCWrite = 1'b0;
			IF_IDWrite = 1'b0;
			Stall = 1'b1;

		end
		else begin
			PCWrite = 1'b1;
			IF_IDWrite = 1'b1;
			Stall = 1'b0;

		end
	end

endmodule
