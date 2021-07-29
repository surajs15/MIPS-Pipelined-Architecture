`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     MIPS_FORWARDING
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////FORWARDING UNIT//////////////////////////////////////////////
module MIPS_FORWARDING(
	input   RegWriteMEM,
	input   RegWriteWB,
	input	[4:0]WriteRegMEM,
	input	[4:0]WriteRegWB,
	input	[4:0]RsEX,
	input	[4:0]RtEX,
	output	reg [1:0] ForwardA,
	output	reg [1:0] ForwardB
);
	// FORWARDS DATA FROM MEM OR WB STAGE TO THE EX STAGE
	always @(RegWriteMEM, RegWriteWB, WriteRegMEM, WriteRegWB, RsEX, RtEX)
	begin
		if((RegWriteMEM == 1'b1) && (WriteRegMEM != 5'b0) && (WriteRegMEM == RsEX)) begin
			ForwardA = 2'b10;		//1A TPYE FORWARDING
		end 	

		else if((RegWriteMEM == 1'b1) && (WriteRegMEM != 5'b0) && (WriteRegMEM == RtEX)) begin
			ForwardB = 2'b10;		//1B TPYE FORWARDING
		end 

		else if ((RegWriteWB == 1'b1) && (WriteRegWB != 5'b0)) begin
			if(!((RegWriteMEM == 1'b1) && (WriteRegMEM != 5'b0) && (WriteRegMEM == RsEX))) begin
			 if(WriteRegWB == RsEX) begin
				ForwardA = 2'b01;		//2A TPYE FORWARDING
				end
			end
		end
		
		else if ((RegWriteWB == 1'b1) && (WriteRegWB != 5'b0)) begin
			if(!((RegWriteMEM == 1'b1) && (WriteRegMEM != 5'b0) && (WriteRegMEM == RtEX))) begin
			 if(WriteRegWB == RtEX) begin
				ForwardB = 2'b01;		//2B TPYE FORWARDING
				end
			end
		end
		else begin
			ForwardA = 2'b00;
			ForwardB = 2'b00;
		
		end



	end

endmodule
