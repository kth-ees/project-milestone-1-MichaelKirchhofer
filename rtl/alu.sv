module alu #(
  BW = 16 // bitwidth
  ) (
  input  logic unsigned [BW-1:0] in_a,
  input  logic unsigned [BW-1:0] in_b,
  input  logic             [3:0] opcode,
  output logic unsigned [BW-1:0] out,
  output logic             [2:0] flags // {overflow, negative, zero}
  );

  // Complete your RTL code here


  logic signed [BW-1:0] a_s,b_s,out_s;
  logic overflow;
  assign a_s = in_a;
  assign b_s = in_b; 

  always_comb begin
    out_s = '0;
    overflow   = 1'b0;
     case (opcode)
        4'b0000: begin
          out_s = a_s + b_s; // ADD
          overflow = ~(a_s[BW-1] ^ b_s[BW-1]) & (a_s[BW-1] ^ b_s[BW-1] ^out_s[BW-1]); // overflow
        end
        4'b0001: begin
          out_s = a_s - b_s; // SUB
          overflow = (a_s[BW-1] ^ b_s[BW-1]) & (a_s[BW-1] ^ out_s[BW-1]); // overflow
        end
        4'b0010: out_s = in_a & in_b; // AND
        4'b0011: out_s = in_a | in_b; // OR
        4'b0100: out_s = in_a ^ in_b; // XOR
        4'b0101: out_s = in_a + 1;    // INC
        4'b0110: out_s = in_a;   // PASS A
        4'b0111: out_s = in_b;   // PASS B
        default: out_s = '0;           // NOP or undefined operation
      
     endcase
  end
  
  assign out = out_s;
  assign flags[2] = overflow; // overflow
  assign flags[1] = out_s[BW-1]; // negative
  assign flags[0] = (out_s == '0) ? 1'b1 : 1'b0; // zero
endmodule




