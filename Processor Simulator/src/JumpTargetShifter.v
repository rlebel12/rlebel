// Takes in bits 25-0 from instruction, sign extends to 28 bits, and shifts left 2, and creates jump address
module JumpTargetShifter(in, PC_next, out);
	input [25:0] in;
	input [31:0] PC_next;
	output reg [31:0] out;
	always @(*) begin
		out <= 0;
		out[27:2] <= in[25:0];
		out[31:28] <= PC_next[31:28];
	end
endmodule
