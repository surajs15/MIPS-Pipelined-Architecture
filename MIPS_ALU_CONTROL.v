`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     ALU CONTROL UNIT
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//


//////////////////////////////////////ALU CONTROL UNIT///////////////////////////////////////
module MIPS_ALU_CONTROL(
	input   [1:0] ALUOPEX,		//ALUOP Signal from COntrol Unit
	input   [5:0] Function,		//Function Field of INstruction
	output	reg [3:0] ALUCT		//ALU Control Signal
);

	always@(ALUOPEX, Function)
	begin
	case(ALUOPEX)
		2'd0: ALUCT = 4'b0010;		// LW & SW Instruction
		2'd1: ALUCT = 4'b0110;		// BEQ Instruction
		2'd2:	
			if(Function == 6'b100000)			//R-TYPE ADD INSTRUCTION
				ALUCT = 4'b0010;			
			else if( Function == 6'b100010)	// R-TYPE SUB INSTRUCTION
				ALUCT = 4'b0110;
			else if( Function == 6'b100100)	// R-TYPE AND INSTRUCTION 
				ALUCT = 4'b0000;	
			else if( Function == 6'b100101)	//R-TYPE OR INSTRUCTION
				ALUCT = 4'b0001;
			else if( Function == 6'b101010)	// R-TYPE SLT INSTRUCTION
				ALUCT = 4'b0111;
			else if( Function == 6'b100111)	// R-TYPE NOR INSTRUCTION
				ALUCT = 4'b1100;		
			else if( Function == 6'b100110)	// R-TYPE XOR INSTRUCTION
				ALUCT = 4'b1101;	
	endcase
	end
endmodule
	
