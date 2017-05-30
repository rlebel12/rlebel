module PC(clk,rst,PC_in,PC_out);
	input clk, rst;
	input [31:0] PC_in;
	output reg [31:0] PC_out;
	always @(posedge rst or posedge clk) begin
		if (rst) begin
			PC_out <= 12288; // 0x3000
		end else begin 
			PC_out <= PC_in;
		end
	end
endmodule
