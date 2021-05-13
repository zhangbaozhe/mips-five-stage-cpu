/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 1.2.0. DO NOT MODIFY.
*/

`ifndef _MAIN_MEMORY
`define _MAIN_MEMORY

module MainMemory
    ( // Inputs
      input  CLOCK // clock
    , input  RESET // reset
    , input  ENABLE
    , input [31:0] FETCH_ADDRESS
    , input [64:0] EDIT_SERIAL // {1'b[is_edit], 32'b[write_add], 32'b[write_data]}

      // Outputs
    , output reg [31:0] DATA
    );
  // /home/jimmy/VNMCC/src/MIPS/RAM.hs:40:1-7
  wire signed [63:0] c$wild_app_arg;
  wire  c$app_arg;
  // /home/jimmy/VNMCC/src/MIPS/RAM.hs:40:1-7
  wire signed [63:0] c$wild_app_arg_0;
  // /home/jimmy/VNMCC/src/MIPS/RAM.hs:40:1-7
  wire [63:0] a1;
  // /home/jimmy/VNMCC/src/MIPS/RAM.hs:40:1-7
  wire signed [63:0] wild;
  // /home/jimmy/VNMCC/src/MIPS/RAM.hs:40:1-7
  wire signed [63:0] wild_0;
  // /home/jimmy/VNMCC/src/MIPS/RAM.hs:40:1-7
  wire [63:0] ds;
  wire [31:0] c$i;

  assign c$wild_app_arg = $unsigned({{(64-32) {1'b0}},FETCH_ADDRESS});

  assign c$app_arg = EDIT_SERIAL[64:64] ? 1'b1 : 1'b0;

  assign c$i = ds[63:32];

  assign c$wild_app_arg_0 = $unsigned({{(64-32) {1'b0}},c$i});

  // blockRam begin
  reg [31:0] DATA_RAM [0:512-1];

  reg [16383:0] ram_init;
  integer i;
  initial begin
    $display("I am initializing");
    ram_init = {32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000,32'b00000000000000000000000000000000};
    for (i=0; i < 512; i = i + 1) begin
      DATA_RAM[512-1-i] = ram_init[i*32+:32];
    end
  end

  always @(posedge CLOCK) begin : DATA_blockRam
    if (c$app_arg & ENABLE) begin
      /* $display("I am writing"); */
      DATA_RAM[(wild_0)] = ds[31:0];
    end
    
  end
  always @(*) begin
    /* reading not affetced by CLK */
    DATA = DATA_RAM[(wild)];
  end
  // blockRam end

  assign a1 = EDIT_SERIAL[63:0];

  assign wild = $signed(c$wild_app_arg);

  assign wild_0 = $signed(c$wild_app_arg_0);

  assign ds = EDIT_SERIAL[64:64] ? a1 : ({64 {1'bx}});


endmodule

`endif