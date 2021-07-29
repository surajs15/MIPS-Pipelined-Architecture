`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Suraj Salian
// 
// Create Date:    19:41:11 02/17/2021 
// Design Name: 
// Module Name:     MIPS CORE
// Project Name: 

// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//

////////////////////////////////// MIPS CORE///////////////////////////////////////
module MIPS_CORE(
	input   GlobalClock,
	input   GlobalReset	
);
	// Wires used to connect various modules
	wire [31:0] PCin, PCout;
	wire [31:0] PCsum, SumAdd;				
	wire [31:0] Instruction;			
	wire PCSrc, Equal;
	wire IF_FLUSH;
	wire [31:0] PCoutID, InstructionID;
	wire MemReadID, MemwriteID, MemtoregID, RegWriteID, RegDstID, ALUsrcID, BranchID; 
	wire MemReadMID, MemwriteMID, MemtoregMID, RegWriteMID, RegDstMID, ALUsrcMID; 
	wire [1:0] ALUOPMID;
	wire [1:0] ALUOPID;
	wire [31:0] ImmExtID;

	wire MemReadEX, MemwriteEX, MemtoregEX, RegWriteEX, RegDstEX, ALUsrcEX; 
	wire [1:0] ALUOPEX;
	wire [31:0] ImmExtEX, ImmShl;
	wire [4:0] RsEX, RtEX, RdEX;
	wire MemReadMEM, MemwriteMEM, MemtoregMEM, RegWriteMEM; 
	wire [4:0] WriteRegEX, WriteRegMEM, WriteRegWB;
	wire [31:0] ReadData1, ReadData2, ReadData1EX, ReadData2EX, ReadData1WB, ReadData1MEM, ReadData2MEM;
	wire [3:0] ALUCT;
	wire [1:0] ForwardA, ForwardB;
	wire [31:0] Interdata, ALUinput1, ALUinput2, ALUResult;
	wire [31:0] ALUinput2MEM, ALUResultMEM, ALUResultWB;
	wire MemtoregWB, RegWriteWB;
	wire [31:0] MemReadDataMEM,MemReadDataWB; 
	wire PCWrite, IF_IDWrite, Stall;
	wire [31:0] WriteDataWB;

/////////////////////////////////////////////// INSTRUCTION FETCH////////////////////////////////////////////////
	//Branch or Not MUX
	MIPS_MUX #(32) m0 (PCsum, SumAdd, PCSrc, PCin);
	//PC MODULE  
	MIPS_PC pc0 ( GlobalClock, GlobalReset, PCWrite, PCin, PCout); // INPUTS GLOBAL CLOCK , GLOBAL RESET
	//INSTRUCTION MEMORY
	MIPS_INSTMEM im0 (PCout, Instruction);
	//ADDER MODULE-0
	MIPS_ADDER a0 (PCout,32'h4, PCsum);
	// IF/ID Register
	MIPS_IF_ID ifid ( GlobalClock, PCsum, Instruction,PCSrc, IF_IDWrite, PCoutID, InstructionID);


/////////////////////////////////////////////// INSTRUCTION DECODE//////////////////////////////////////////////////////////////////////////
	//CONTROL UNIT
	MIPS_CONTROLUNIT cu0 (InstructionID[31:26], MemReadID, MemwriteID, MemtoregID, RegWriteID, RegDstID, ALUsrcID, BranchID, ALUOPID);
	//SIGN EXTENSION UNIT
	MIPS_SIGNEXT se0 (InstructionID[15:0], ImmExtID);	
	//SHIFT LEFT BY-2 MODULE
	MIPS_SHL2 sh0 (ImmExtID,ImmShl);
	//ADDER TO CALCULATE BRANCH ADDRESS
	MIPS_ADDER a1 (PCoutID,ImmShl, SumAdd);
	//REGISTER FILE
	MIPS_REGFILE rf0 (GlobalClock, InstructionID[25:21], InstructionID[20:16], WriteRegWB, RegWriteWB , WriteDataWB, ReadData1, ReadData2);
	//HAZARD DETECTION UNIT
	MIPS_HAZARD hz0 (MemReadEX, RtEX, InstructionID[25:21], InstructionID[20:16], PCWrite, IF_IDWrite, Stall);
	//COMPARATOR FOR BEQ INSTRUCTION
	MIPS_COMPARATOR cmp0 (ReadData1, ReadData2, Equal);
	//AND GATE FOR PCsrc SIGNAL
	and ad0 (PCSrc, Equal, BranchID);
	//CONTROL SIGNAL MUX FOR INTRODUCING STALL
	MIPS_CONTROLMUX cm0 (MemReadID, MemwriteID, MemtoregID, RegWriteID, RegDstID, ALUsrcID, ALUOPID, Stall, MemReadMID, MemwriteMID, MemtoregMID
				, RegWriteMID, RegDstMID, ALUsrcMID, ALUOPMID);
	// ID/EX REGISTER
	MIPS_ID_EX idex ( GlobalClock, MemReadMID, MemwriteMID, MemtoregMID, RegWriteMID, RegDstMID, ALUsrcMID, ALUOPMID, ImmExtID 
			 ,  ReadData1, ReadData2, InstructionID[25:21], InstructionID[20:16], InstructionID[15:11], MemReadEX, MemwriteEX 
			, MemtoregEX, RegWriteEX, RegDstEX, ALUsrcEX, ALUOPEX, ReadData1EX, ReadData2EX , ImmExtEX,RsEX, RtEX, RdEX);	
			

	
/////////////////////////////////////////////////////// INSTRUCTION EXECUTE////////////////////////////////////////////////////////////////////////////////
	//MUX FOR SELECTING REGISTER/IMMEDIATE DATA
	MIPS_MUX #(32) m1 (ReadData2EX, ImmExtEX, ALUsrcEX, Interdata);
	//FORWADING UNIT
	MIPS_FORWARDING for0 (RegWriteMEM, RegWriteWB, WriteRegMEM, WriteRegWB, RsEX, RtEX, ForwardA, ForwardB);
	// FORWARDING MUX FOR ALU INPUT-1
	MIPS_MUX_4 #(32) m40(ReadData1EX, WriteDataWB, ALUResultMEM, ForwardA, ALUinput1);
	// FORWARDING MUX FOR ALU INPUT-2
	MIPS_MUX_4 #(32) m41(Interdata, WriteDataWB, ALUResultMEM, ForwardB, ALUinput2);
	//ALU CONTROL UNIT
	MIPS_ALU_CONTROL ac0(ALUOPEX,ImmExtEX[5:0],ALUCT);
	//ALU
	MIPS_ALU alu0(ALUinput1, ALUinput2, ALUCT, ALUResult);
	// MUX FOR SELECTING THE DESTINATION REG -> Rs/Rt
	MIPS_MUX #(5) m2 (RtEX, RdEX, RegDstEX, WriteRegEX);
	// EX/MEM REGISTER
	MIPS_EX_MEM exmem (GlobalClock, MemReadEX, MemwriteEX, MemtoregEX, RegWriteEX, ALUResult, ALUinput2, WriteRegEX,ReadData2EX, MemReadMEM, MemwriteMEM
		           , MemtoregMEM, RegWriteMEM, ALUResultMEM, ALUinput2MEM, WriteRegMEM, ReadData2MEM);
	

	
////////////////////////////////////////////////// MEMORY STAGE///////////////////////////////////////////////////////////////////////////////////////////////
	// DATA MEMORY MODULE
	MIPS_DATAMEM dm0 (ALUResultMEM, MemwriteMEM, MemReadMEM, ReadData2MEM, MemReadDataMEM);
	// MEM/WB REGISTER
	MIPS_MEM_WB memwb (GlobalClock, MemtoregMEM, RegWriteMEM, ALUResultMEM, WriteRegMEM,MemReadDataMEM, MemtoregWB, RegWriteWB, ALUResultWB, WriteRegWB
			   ,MemReadDataWB);

////////////////////////////////////////////////// WRITE BACK STAGE///////////////////////////////////////////////////////////////////////////////////////////////
	// MUX FOR SELECTING MEMORY DATA / ALU RESULT
	MIPS_MUX  #(32) m3(ALUResultWB, MemReadDataWB, MemtoregWB, WriteDataWB);

	
endmodule
