module ALU(ctrl, in0,in1,ALUresult, Zero);
	input [3:0] ctrl;
	input signed [31:0] in0, in1;
	output ALUresult, Zero;
	reg signed [31:0] ALUresult;
	reg Zero;
	always @(*)
	begin
		case (ctrl)
			0: ALUresult <= in0 & in1;
			1: ALUresult <= in0 | in1;
			2: ALUresult <= in0 + in1;
			6: ALUresult <= in0 - in1;
			7: begin
				if (in0 < in1) ALUresult <= 1;
				else ALUresult <= 0;
			   end
			default: ALUresult <= 0;
		endcase
		if (ALUresult == 0) Zero <= 1;
		else Zero <= 0;
	end
endmodule