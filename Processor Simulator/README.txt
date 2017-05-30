Testbench to run: cpu_tb.v

Simulation time: 6100000 ps (At least this duration, as testbench will also stop simulation at this point.
Just be sure to select 'No' if a window pops up asking to finish the simulation.)

# Project Info
As a final project for a computer architecture course, I was tasked with simulating a single-cycle processor
using the MIPS instruction set.  The processor supports the following instructions: add, addi, slt, beq, j, lw, sw.

The memory.v module is an integrated instruction/data memory unit.  This module, along with MinMax.hexdump,
was provided to us.  At runtime, the text/data segments are loaded into memory.

The given program finds the smallest and largest values from an unorganized list of integers.  The register
contents should be left in this state at completion:
# Register           0: 0x00000000 - Register           1: 0x00000000
# Register           2: 0x00000000 - Register           3: 0x00000000
# Register           4: 0x00000000 - Register           5: 0x00000000
# Register           6: 0x00000000 - Register           7: 0x00000000
# Register           8: 0x00000028 - Register           9: 0x00000000
# Register          10: 0xfffffff0 - Register          11: 0x00000015
# Register          12: 0x00000015 - Register          13: 0x00000001
# Register          14: 0x00000000 - Register          15: 0x00000000
# Register          16: 0x00000000 - Register          17: 0x00000009
# Register          18: 0x00000005 - Register          19: 0x00000009
# Register          20: 0x00000000 - Register          21: 0x00000000
# Register          22: 0x00000000 - Register          23: 0x00000000
# Register          24: 0x00000000 - Register          25: 0x00000000
# Register          26: 0x00000000 - Register          27: 0x00000000
# Register          28: 0x00000000 - Register          29: 0x00000000
# Register          30: 0x00000000 - Register          31: 0x00000000