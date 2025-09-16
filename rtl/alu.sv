/*------------------------------------------------------------------------------
 Project      : IL2234 Project - Milestone 1 -> ALU 
 File         : alu_tb.sv
 Author       : Michael Kirchhofer, Yaowen Fan, Fredrik Kis
 Description  : RTL implementation of the processor ALU (Milestone 1). Contains
 ADD, SUB, AND, OR, XOR, INC, PASS_A and PASS_B functions. Exectutes the
 operations set by the opcode input with the in_a and in_b inputs. The ALU puts
 both the result of the operation, as well as a 3 - bit wide flag vector, which
 signals if an overflow / underflow, negative or zero result occured.
------------------------------------------------------------------------------*/
module alu #(
  parameter int unsigned BW = 16 // bitwidth
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
  assign a_s = $signed(in_a);
  assign b_s = $signed(in_b); 

  always_comb begin
    out_s = '0;
    overflow   = 1'b0;
     case (opcode)

        4'b0000: begin // ADD
          out_s = a_s + b_s; 
          overflow = ~(a_s[BW-1] ^ b_s[BW-1]) & (a_s[BW-1] ^ b_s[BW-1] ^out_s[BW-1]); // overflow
        end

        4'b0001: begin // SUB
          out_s = a_s - b_s; 
          overflow = (a_s[BW-1] ^ b_s[BW-1]) & (a_s[BW-1] ^ out_s[BW-1]); // overflow
        end
        4'b0010: out_s = in_a & in_b; // AND
        4'b0011: out_s = in_a | in_b; // OR
        4'b0100: out_s = in_a ^ in_b; // XOR

        4'b0101: begin // INC
           out_s = a_s + 1'b1;
           overflow = (~a_s[BW-1] & out_s[BW-1]); // overflow if a changes sign
        end   
        4'b0110: out_s = in_a;   // PASS A
        4'b0111: out_s = in_b;   // PASS B

        default: begin // default
          out_s = '0;           
          overflow = 1'b0;
        end     
     endcase
  end
  
  assign out = out_s;
  // 3-bit flag output -> overflow, negative, zero's
  assign flags = {overflow, out_s[BW-1], (out_s == '0)};


endmodule




