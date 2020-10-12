# Lab 03: Structural ALU

Please submit your answers to the following problems by commiting and pushing
your code and testbench to github.

We're going to build a bit-slice ALU in this lab.  I've reworked the Makefile to
hopefully make things a little less confusing.

Now you can build the following targets:

* test_alu_slice.vcd - Makes test_alu_slice.bin and runs it. This tests the
  ALU_SLICE "bitslice."
* test_alu.vcd - Makes test_alu.vcd and runs it. This tests the whole ALU.

If you want to lint the files that are compiled, just run:

* test_alu_slice.lint - lints everything for testing ALU_SLICE
* test_alu.lint - lints everything for testing the full ALU

## Part 1 - ALU Slice

### What 

We're going to build a bit-slice ALU, which means we're going to compute each
individual bit of the result on a bit-by-bit basis.  Implement the following
single bit operations in a ALU_SLICE, which we'll assemble into a full ALU in
Part 2:

    ADD:  R + Cout = A +  B + Cin
    SUB:  R + Cout = A + ~B + Cin
    XOR:  R = A ^ B
    SLT:  R + Cout = A + ~B + Cin, remember A - B < 0
    AND:  R = A & B
    NAND: R = ~(A & B)
    NOR:  R = ~(A | B)
    OR:   R  = A | B

The testbench will just print all the values so you can do some hand checking.

You may use any number of gates you like from the following set:

* nand - 4 transistors, 1 delay
* nor - 4 transistors, 1 delay
* not - 2 transistors, 1 delay
* xor - 12 transistors, 1 delay

Include a drawing of your ALU bitslice at the gate level in your repo as a PDF.
Please label intermediate nodes with your wire names to help us grade your lab.

You may draw the MUX as a black box with 8 inputs and 1 output.

Additional Deliverables:

* For each operation above, please calculate the worst case delay from any input
  to any output, i.e. from Ctrl, A, B, Cin to R, Cout. 
* Please also calculate the total area of your ALU bitslice design in
  transistors and report that as well.

There is only one worst case delay path from the inputs to the output, i.e. for
NAND implemented as a a single gate the delay is going to be one, because you go
from A/B to the mux. For an adder it will be multiple delays.

For the purposes of this exercise, you may assume the mux to R to be a delay of
0, we're just trying to evaluate your design. You may also assume the MUX takes
0 transistors for a similar reason.

You will NOT be evaluated on the area/delay efficiency of your design, just its
correctness. We're just giving more opportunities to practice how to estimate
delay. If you feel up for it, try to optimize your design.

I've already built the mux for you, but you will need to update the inputs to
the mux. For example, the wire you use for the sum should be connected to the
sum input of the mux.

### Why

We'll need an ALU for the processor, so it's time to familiarize ourselves with
how it's built!

## Part 2 - Full ALU

###  What

Combine your bit slices into a single ALU unit. Make sure to be careful with
SLT, which expects a single bit to be set if A < B. Your ALU will also have to
generate a carry out bit to check for unsigned overflow as well as a 2's
complement overflow.

Currently we have a W=4 bit ALU. Feel free to test against a 4-bit ALU testbench
(provided), but the final testbench will be a targeted (not exhaustive)
testbench at an arbitary bit width, so your solution should be parameterized for
multiple values of W.

A simple way to do that is to set W=5 during your testing--that will allow you
to cover various cases without dramatically increasing test runtime.

### Why

The full ALU has some additional structures that need to be implemented outside
of the ALU slice, and we'll need a complete ALU for the CPU.

## Heavy Lift - Zero and Parity

### What

Build a parameterized zero detect and parity detect.

* Input: W-bit number
* Output for Zero: 1 if all bits are 0, else 0.
* Output for Parity: 1 if odd numbers of 1s in the W-bit number, else 0.
