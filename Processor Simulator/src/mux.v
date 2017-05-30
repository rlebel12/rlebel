module mux32(i0,i1, out, sel);
	input [31:0] i0, i1;
	input sel;
	output reg [31:0] out;
	always @ (i0 or i1 or sel)
	begin
		if (sel == 1)
			out <= i1;
		else out <= i0;
	end
endmodule