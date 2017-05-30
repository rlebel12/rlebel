// Takes bits 15-0 from instruction, extends to 32 bits
module SignExtendModule(in, out);
	input [15:0] in;
	output reg [31:0] out;
	always @(*) begin
		out <= 0;
		out <= $signed(in);
	end
endmodule