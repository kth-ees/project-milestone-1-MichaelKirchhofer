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
    
    // ------------------- ADD
    in_a = 16'h0002; in_b = 16'h0002; opcode = 4'b0000;
    #5ns;
    in_a = 16'hFFFF; in_b = 16'hFFFF;
    #5ns;
    // ------------------- SUB
    in_a = 16'h0005; in_b = 16'h0003; opcode = 4'b0001; 
    #5ns;
    in_a = 16'h0002; in_b = 16'h0003;
    #5ns;
    in_a = 16'h7FFF; in_b = 16'hFFFF; // 32767 - (-1) = overflow to -32768
    #5ns;
    in_a = 16'h7FFF; in_b = 16'h8000; // 32767 - (-32768) = overflow to -1
    #5ns;
    in_a = 16'h000F; in_b = 16'h000F; // Test for Zero flag
    #5ns;
    // ------------------- AND
    in_a = 16'h0010; in_b = 16'h0010; opcode = 4'b0010;
    #5ns;
    in_a = 16'h000F; in_b = 16'hF000; 
    #5ns;
    in_a = 16'hFFFF; in_b = 16'hFFFF;
    #5ns;

    // ------------------- OR
    in_a = 16'h0010; in_b = 16'h0010; opcode = 4'b0011;
    #5ns;
    in_a = 16'h000F; in_b = 16'hF000;
    #5ns;
    in_a = 16'hFFFF; in_b = 16'hFFFF;
    #5ns;
    
    // ------------------- XOR
    in_a = 16'h0010; in_b = 16'h0010; opcode = 4'b0100;
    #5ns;
    in_a = 16'h000F; in_b = 16'hF000; 
    #5ns;
    in_a = 16'hFFFF; in_b = 16'hFFFF;
    #5ns;

    // ------------------- INC (in_b can stay at old value)
    in_a = 16'h0001; opcode = 4'b0101;
    #5ns;
    in_a = 16'hFFFF;
    #5ns;

    // ------------------- PASS A (in_b can stay at old value)
    in_a = 16'h0FF0; opcode = 4'b0110;
    #5ns;

    // ------------------- PASS B (in_a can stay at old value)
    in_b = 16'hFFF0; opcode = 4'b0111;
    #5ns;

    // -------------------DEFAULT
    opcode = 4'b1111;
    #5ns;
    
    // Complete your testbench code here
  end
endmodule
