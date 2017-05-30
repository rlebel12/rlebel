`timescale 1ns/100ps

module cpu_tb;
reg clk, rst;
integer j, x, clockCycle; // j is just a loop iterator, x used to print transcript during low-power clock segments.
CPU DUT(clk, rst);

// Initialize values
initial begin
	clk = 0;
	rst = 1;
	clockCycle = 0;
	x = 0;
	#60 rst = 0;
end

// Clock
always begin
	#20 clk=~clk;
	x = x+1;
	if (x%2 == 0) begin
	$display("Cycle: %d", clockCycle);
	$display("Hex Instruction: 0x%h", DUT.Instr);
	$display("Opcode:  0x%h", DUT.opcode);
	$display("ALU inputs: 0x%h, 0x%h", DUT.RegReadData1, DUT.ALUInput2);
	for(j=0; j<32; j = j+2) begin
		$display("Register %d: 0x%h - Register %d: 0x%h", j, DUT.regfile.regfile[j], j+1, DUT.regfile.regfile[j+1]);
	end
	$display("\n");
	end
end

always begin
	#40 clockCycle <= clockCycle+1;
	if(DUT.opcode==63) begin
		$display("Reached HLT instruction at cycle %d", clockCycle);
	end
end

initial begin
	#6100 $finish;
end
endmodule
