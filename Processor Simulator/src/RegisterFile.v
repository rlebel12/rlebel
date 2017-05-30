module regfile(clk,rst, readadd0,readadd1,writeadd,writedata,writeenable,readdata0,readdata1);
	input clk, rst, writeenable;
	integer i;
	input [4:0] readadd0, readadd1, writeadd;
	input [31:0] writedata;
	output readdata0, readdata1;
	reg [31:0] regfile [0:31];
	reg [31:0] readdata0, readdata1;
	initial begin
		for(i = 0; i < 32; i = i+1) begin
			regfile[i]<=0;
		end
	end
	always @(posedge rst or posedge clk)
	begin
		if (writeenable == 1) begin
			if (writeadd > 0) regfile[writeadd] <= writedata;
		end
		if (rst) begin
			for(i = 0; i < 32; i = i+1) begin
				regfile[i]<=0;
			end
		end
	end
	always @(readadd0 or readadd1) begin
		readdata0 <= regfile[readadd0];
		readdata1 <= regfile[readadd1];
	end
endmodule