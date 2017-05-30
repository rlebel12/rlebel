// Takes in 32-bit sign-extended immediate field from instr[15:0], and shifts left 2
module BranchTargetShifter(in, out);
	input [31:0] in;
	output reg [31:0] out;
	always @(*) begin
		out <= 0;
		out[17:2] <= in[15:0];
	end
endmodule