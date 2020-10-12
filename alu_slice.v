`include "defines.v"
`timescale 1ns / 1ps

module ALU_SLICE
 #(parameter DLY = 5)
  (input [2:0] Ctrl,
   input A, B, Cin,
   output reg R, Cout);

  // Gates and wires go here
  wire nandwire, andwire;
  nand NAND1(nandwire, A, B);
  not NOT1(andwire, nandwire);

  wire norwire, orwire;
  nor NOR1(norwire, A, B);
  not NOT2(orwire, norwire);

  wire xorwire;
  xor XOR1(xorwire, A, B);

  wire addwireR, addwireCo, bcNand, xorB, abNand, abXor, acNand;
  xor XOR2(xorB, B, Ctrl[0]);
  nand NAND2(bcNand, xorB, Cin);
  nand NAND3(abNand, A, xorB);
  nand NAND4(acNand, A, Cin);
  xor XOR3(abXor, A, xorB);
  nand NAND5(addwireCo, abNand, acNand, bcNand); // a nand (b xor S[0])
  xor XOR4(addwireR, abXor, Cin);

  // MUX
  // Update 1'b0 to the appropriate wire from above
  always @* begin
    case (Ctrl)
      `ADD_:  begin R = addwireR; Cout = addwireCo; end
      `SUB_:  begin R = addwireR; Cout = addwireCo; end 
      `XOR_:  begin R = xorwire; end 
      `SLT_:  begin R = addwireR; Cout = addwireCo; end
      `AND_:  begin R = andwire; end
      `NAND_: begin R = nandwire; end
      `NOR_:  begin R = norwire; end
      `OR_:   begin R = orwire; end
      default: /* default catch */;
    endcase
  end

endmodule
