module alu_tb;

  parameter BW = 16; // bitwidth

  logic unsigned [BW-1:0] in_a;
  logic unsigned [BW-1:0] in_b;
  logic             [3:0] opcode;
  logic unsigned [BW-1:0] out;
  logic             [2:0] flags; // {overflow, negative, zero}

  // Instantiate the ALU
  alu #(BW) dut (
    .in_a(in_a),
    .in_b(in_b),
    .opcode(opcode),
    .out(out),
    .flags(flags)
  );

  // Generate stimuli to test the ALU
  initial begin
    in_a = '0;
    in_b = '0;
    opcode = '0;
    #10ns;
    in_a = 16'h0002; in_b = 16'h0002; opcode = 4'b0000; // ADD
    #10ns;
    in_a = 16'hFFFF; in_b = 16'hFFFF;// ADD
    #10ns;
    in_a = 16'h0005; in_b = 16'h0003; opcode = 4'b0001; // SUB
    #10ns;
    in_a = 16'h0002; in_b = 16'h0003; // SUB
    #10ns;
    in_a = 16'h7FFF; in_b = 16'hFFFF; // 32767 - (-1) = overflow to -32768
    #10ns;
    in_a = 16'h7FFF; in_b = 16'h8000; // 32767 - (-32768) = overflow to -1
    #10ns;
    in_a = 16'h000F; in_b = 16'h000F; // Test for Zero flag
    #10ns;
    // Complete your testbench code here
  end
endmodule
