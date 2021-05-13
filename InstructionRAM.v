/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 1.2.0. DO NOT MODIFY.
*/
`ifndef _INSTRUCTION_RAM
`define _INSTRUCTION_RAM

module InstructionRAM
    ( // Inputs
      input  CLOCK // clock
    , input  RESET // reset
    , input  ENABLE
    , input [31:0] FETCH_ADDRESS

      // Outputs
    , output reg [31:0] DATA
    );
  // /home/jimmy/VNMCC/src/MIPS/InstructionMem.hs:(17,1)-(23,30)
  wire signed [63:0] c$wild_app_arg;
  // /home/jimmy/VNMCC/src/MIPS/InstructionMem.hs:(17,1)-(23,30)
  wire signed [63:0] c$wild_app_arg_0;
  // /home/jimmy/VNMCC/src/MIPS/InstructionMem.hs:(17,1)-(23,30)
  wire [31:0] x1;
  // /home/jimmy/VNMCC/src/MIPS/InstructionMem.hs:(17,1)-(23,30)
  wire signed [63:0] wild;
  // /home/jimmy/VNMCC/src/MIPS/InstructionMem.hs:(17,1)-(23,30)
  wire signed [63:0] wild_0;
  wire [63:0] DATA_0;
  wire [63:0] x1_projection;

  assign c$wild_app_arg = $unsigned({{(64-32) {1'b0}},FETCH_ADDRESS});

  assign c$wild_app_arg_0 = $unsigned({{(64-32) {1'b0}},x1});

  assign DATA_0 = {64 {1'bx}};

  // blockRamFile begin
  reg [31:0] RAM [0:512-1];

  initial begin
    $display("Reading instruction to RAM.");
    $readmemb("instruction.bin",RAM);
    $display("RAM[0]: \t %32b", RAM[0]);
    $display("RAM[1]: \t %32b", RAM[1]);
  end

  always @(*) begin : InstructionRAM_blockRamFile
    if (1'b0 & ENABLE) begin
      RAM[(wild_0)] <= DATA_0[31:0];
    end
    if (ENABLE) begin
      DATA <= RAM[(wild)];
      // $display("From INS_RAM. DATA: %32b", DATA);
    end
  end
  // blockRamFile end

  assign x1_projection = {64 {1'bx}};

  assign x1 = x1_projection[63:32];

  assign wild = $signed(c$wild_app_arg);

  assign wild_0 = $signed(c$wild_app_arg_0);


endmodule

`endif

