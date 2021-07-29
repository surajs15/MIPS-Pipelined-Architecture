`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     REGISTER FILE
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
/////////////////////////////////////REGISTER FILE//////////////////////////////////
module MIPS_REGFILE(
	input   CLK,			//INPUT CLOCK
	input 	[4:0] ReadReg1,		//READ REG-1
	input 	[4:0] ReadReg2,		//READ REG-2
	input 	[4:0] WriteReg,		//WRITE REG
	input   RegWrite,		//REGISTER WRITE SIGNAL
	input 	[31:0] WriteData,	//WRITE DATA
	output	reg [31:0] ReadData1,	//OUTPUT READ DATA1
	output	reg [31:0] ReadData2	//OUTPUT READ DATA2
);
	reg [31:0] REG[31:0];		//REG FILE FOR 32 REGS
	initial begin
		$readmemb("REGINP.mem", REG); // Reading from REGINP.mem file from project directory
	end

	
	always @(posedge CLK)
	begin
		if(RegWrite == 1'b1)		//WRITE OPERATION
		begin
			REG[WriteReg] = WriteData;
			REG[0] = 32'b0;
			$writememb("REGDATA.mem", REG);	// Storing to REGDATA.mem file in project directory
		end
	
	end

	always @(ReadReg1,ReadReg2)		//READ REGISTER DATA
	begin
		
		ReadData1 = REG[ReadReg1];
		ReadData2 = REG[ReadReg2];
		
	end

	

	
endmodule
