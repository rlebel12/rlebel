`define EOF 32'hFFFF_FFFF
`define NULL 0
`timescale 1ns/100ps

module CPU(clk,rst);
	// CPU inputs
	input clk, rst;

	// CPU wires
	wire[31:0] PC_in, PC_out, PC_next; // In/Out for PC, and PC+4. Pc_in is output of JumpMux
	wire[31:0] Instr; // In/Out for inst mem
	wire[31:0] data_out; // Out for data mem

	wire[25:0] JumpTarget; // Instr[25:0]
	wire[31:0] JumpAddr; // Jump address
	wire[31:0] BranchMuxOut;
	wire[31:0] BranchAddr;

	wire[31:0] immExtended, immExtendedShifted; // Immediate field after sign-extension, and then after shift-left-2
	wire[15:0] imm;  // Immediate field (Instr[15:0])
	wire[5:0] opcode, funct;  // Instr[31:26], Instr[5:0]
	wire[4:0] rs, rt, rd, WriteRegister; // Address inputs to register file
	wire[31:0] RegWriteData, RegReadData1, RegReadData2;  // Data inputs/outputs for register file. RegWriteData output of MemtReg mux

	wire[31:0] ALUInput2, ALUResult;
	
	
	// Control signals
	wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Zero, BranchMuxSel;
	wire[1:0] ALUOp;
	wire[3:0] ALUCtrl;
	
	// Simple assignments
	assign opcode = Instr[31:26];
	assign rs = Instr[25:21];
	assign rt = Instr[20:16];
	assign rd = Instr[15:11];
	assign imm = Instr[15:0];
	assign funct = Instr[5:0];
	assign JumpTarget = Instr[25:0];
	assign PC_next = PC_out + 4;
	assign BranchMuxSel = Branch & Zero;
	assign BranchAddr = immExtendedShifted + PC_next;

	//MUXes
	mux5 WriteRegisterMUX(rt,rd,WriteRegister,RegDst);
	mux32 ALUInputMUX(RegReadData2,immExtended, ALUInput2, ALUSrc);
	mux32 BranchMUX(PC_next, BranchAddr, BranchMuxOut, BranchMuxSel);
	mux32 JumpMUX(BranchMuxOut, JumpAddr, PC_in, Jump);
	mux32 WriteDataMUX(ALUResult, data_out, RegWriteData, MemtoReg);

	// Modules
	Memory Memory(clk, PC_out,  Instr, ALUResult, RegReadData2, MemRead, MemWrite, data_out);
	PC PC(clk,rst,PC_in,PC_out);
	regfile regfile(clk, rst, rs, rt, WriteRegister, RegWriteData, RegWrite, RegReadData1, RegReadData2);
	ControlUnit ControlUnit(opcode,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump,ALUOp);
	ALUControl ALUControl(ALUOp, funct, ALUCtrl);
	ALU ALU(ALUCtrl, RegReadData1, ALUInput2, ALUResult, Zero);
	SignExtendModule SignExtendModule(imm, immExtended);
	BranchTargetShifter BranchTargetShifter(immExtended, immExtendedShifted);
	JumpTargetShifter JumpTargetShifter(JumpTarget, PC_next, JumpAddr);
	
endmodule