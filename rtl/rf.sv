/*------------------------------------------------------------------------------
 Project      : IL2234 Project - Milestone 2 -> Register File 
 File         : rf.sv
 Author       : Michael Kirchhofer, Yaowen Fan, Fredrik Kis
 Description  : RTL implementation of the processor Register File (Milestone 2).
------------------------------------------------------------------------------*/


module name #(
  parameter int unsigned BW = 16, // bitwidth
  parameter int unsigned DEPTH = 32  // address width
  // Register file with 32 x 16 bit registers
) (
  input logic  clock, rst_n, chip_en,write_en_n,
  input logic [BW-1:0]  data_in, 
  input logic [$clog2(DEPTH)-1:0] read_addr_1, read_addr_2, write_addr,
  output logic[BW-1:0] data_out_1, data_out_2,

);


// Synchronrous logic
always_ff @(posedge ck or negedge rst_n) begin
  if(!rst_n) begin
    data_out_1 <= '0;
    data_out_2 <= '0;
  end else if (chip_en && !write_en_n) begin // write data_in to register at write_addr
    
  end
end

always_comb begin

end

endmodule