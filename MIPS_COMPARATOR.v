`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     MIPS_COMPARATOR
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
////////////////////////////////////// COMPARATOR ///////////////////////////////////////
module MIPS_COMPARATOR(
	input   [31:0] Data1, //Input-1
	input   [31:0] Data2,	//Input-2
	output	reg Result	//Result
);
	//Comparator used by BEQ instruction in ID Stage
	always @(Data1, Data2)
	begin
		if(Data1 == Data2) begin
			Result = 1'b1;
		end	
		else begin
			Result = 1'b0;
		end
	end

endmodule
