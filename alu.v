`include "defines.v"
`timescale 1ns / 1ps

module ALU
 #(parameter W = 4,
           DLY = 5)
  (input     [2:0] Ctrl,// Control word to select operation
   input      [W-1:0] A,// Input Operand
   input      [W-1:0] B,// Output Operand
   output reg [W-1:0] R,// Result 
   output reg      cout,// Was there a carry out? Unsigned overflow
   output reg overflow);// Result overflowed

  wire [W:0]   carry;
  wire [W-1:0] result;
  wire slt, sltoverflow;

  assign carry[0] = Ctrl[0];
  
  generate genvar i;
    for (i=0;i<W;i=i+1) begin
      ALU_SLICE #(.DLY(DLY)) slice_inst(Ctrl,A[i],B[i],carry[i],result[i],carry[i+1]);
    end 
  endgenerate
  
  xor XOR2(slt, carry[W], carry[W-1], result[W-1]);

  always @* begin
  case (Ctrl)
    `ADD_:  begin R = result; cout = carry[W]; end
    `SUB_:  begin R = result; cout = carry[W]; end 
    `XOR_:  begin R = result; end 
    `SLT_:  begin R = slt; end
    `AND_:  begin R = result; end
    `NAND_: begin R = result; end
    `NOR_:  begin R = result; end
    `OR_:   begin R = result; end
    default: /* default catch */;
  endcase
  end
endmodule
