`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     MIPS_MUX_4
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
/////////////////////////////////////// PARAMETERIZED 3:1 MUX/////////////////////////
module MIPS_MUX_4 #(parameter SIZE=32) (
	input   [SIZE-1:0] Input1,
	input   [SIZE-1:0] Input2,
	input   [SIZE-1:0] Input3,		
	input 	[1:0] ControlSignal,
	output	reg [SIZE-1:0] Output
);
	always @(Input1, Input2, ControlSignal)
	begin
		case(ControlSignal)
			2'b00 : Output <= Input1;
			2'b01 : Output <= Input2;
			2'b10 : Output <= Input3;
			default: Output <= Input1;
		endcase
	end

	
endmodule
