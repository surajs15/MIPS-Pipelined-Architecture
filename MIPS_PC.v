`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     PROGRAM COUNTER
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//////////////////////////////////////PC MODULE//////////////////////////////////////////////
module MIPS_PC(
	input   CLK,			//INPUT CLOCK
	input   RESET,			//INPUT RESET
	input	PCWrite,
	input 	[31:0] PCin,		//PC INPUT
	output	reg [31:0] PCout	//PC OUT
);
	
	always @(posedge CLK)
	begin 
		//ON RESET PC = 0
		if (RESET == 1'b1)
		begin
			PCout <= 32'b0; 
		end
		//IF PCWrite ==0 Stall the pipeline
		else if(PCWrite == 1'b0) begin
			PCout <= PCout;
		end
		//If PCWrite != 0 then PCout <- PCin
		else
		begin
			PCout <= PCin;
		end
	end

	
endmodule
