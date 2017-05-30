module ControlUnit(opcode, RegDst, ALUSrc, MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump,ALUOp);
	input [5:0] opcode;
	output reg RegDst, ALUSrc, MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump;
	output reg [1:0] ALUOp;
	always @(opcode)
	begin
		case (opcode)
			0: begin // R-format
				RegDst <= 1;
				ALUSrc <= 0;
				MemtoReg <= 0;
				RegWrite <=1;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 0;
				ALUOp <= 2;
				Jump <= 0;
			    end
			35: begin // lw
				RegDst <= 0;
				ALUSrc <= 1;
				MemtoReg <= 1;
				RegWrite <=1;
				MemRead <= 1;
				MemWrite <= 0;
				Branch <= 0;
				ALUOp <= 0;
				Jump <= 0;
			    end
			43: begin // sw
				ALUSrc <= 1;
				RegWrite <=0;
				MemRead <= 0;
				MemWrite <= 1;
				Branch <= 0;
				ALUOp <= 0;
				Jump <= 0;
			    end
			4: begin // beq
				ALUSrc <= 0;
				RegWrite <=0;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 1;
				ALUOp <= 3;
				Jump <= 0;
			    end
			2: begin // Jump
				RegDst <= 0;
				ALUSrc <= 0;
				MemtoReg <= 0;
				RegWrite <=0;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 0;
				ALUOp <= 0;
				Jump <= 1;
			    end
			8: begin // addi
				RegDst <= 0;
				ALUSrc <= 1;
				MemtoReg <= 0;
				RegWrite <= 1;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 0;
				ALUOp <= 0;
				Jump <= 0;
			   end
				
			default:
			    begin
				RegDst <= 0;
				ALUSrc <= 0;
				MemtoReg <= 0;
				RegWrite <=0;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 0;
				ALUOp <= 0;
				Jump <= 0;
			    end
		endcase
	end
endmodule