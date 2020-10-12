`include "defines.v"
`timescale 1ns / 1ps

module ALU_SLICE
 #(parameter DLY = 5)
  (input [2:0] Ctrl,
   input A, B, Cin,
   output reg R, Cout);

  // Gates and wires go here

  // MUX
  // Update 1'b0 to the appropriate wire from above
  always @* begin
    case (Ctrl)
      `ADD_:  begin R = 1'b0; end
      `SUB_:  begin R = 1'b0; end 
      `XOR_:  begin R = 1'b0; end 
      `SLT_:  begin R = 1'b0; end
      `AND_:  begin R = 1'b0; end
      `NAND_: begin R = 1'b0; end
      `NOR_:  begin R = 1'b0; end
      `OR_:   begin R = 1'b0; end
      default: /* default catch */;
    endcase
  end

endmodule
