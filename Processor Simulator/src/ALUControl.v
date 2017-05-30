module ALUControl(ALUOp,Funct,ALUCtrl);
	input [1:0] ALUOp;
	input [5:0] Funct;
	output ALUCtrl;
	reg [3:0] ALUCtrl;
	always @(*)
	begin
		if (ALUOp==2) begin
			case (Funct)
				32: ALUCtrl <= 2;  // add
				34: ALUCtrl <= 6;  // subtract
				36: ALUCtrl <= 0;  // AND
				37: ALUCtrl <= 1;  // OR
				42: ALUCtrl <= 7;  // slt
				default: ALUCtrl <= 1; // arbitrary
			endcase
		end else begin
			case (ALUOp)
				0: ALUCtrl <= 2;  // addi, lw, sw
				1: ALUCtrl <= 0;  // andi
				2: ALUCtrl <= 1;  // ori
				3: ALUCtrl <= 6;  // beq
				default: ALUCtrl <= 1; // arbitrary
			endcase
		end
	end
endmodule