/* 
 * File Name: StageRegs.v
 * Author:    ZHANG Baozhe
 * Date:      April , 2021
 * ----------------------------
 * This file contains the implementation of the registers 
 * between different stages, i.e., PC, IF/ID, ID/EX, EX/MEM, 
 * and MEM/WB. 
 * 
 */
`ifndef _STAGE_REGS
`define _STAGE_REGS

module PC (
    input               CLK, 
    input               PCWrite, 
    input      [31:0]   in, 
    output reg [31:0]   out
);
    /* 
    * Implementation Notes
    * --------------------
    * INPUTS:
    * CLK      ->      the clock signal
    * PCWrite  ->      the control signal enables PC to write
    * in       ->      input address
    * OUTPUTS:
    * out      ->      new address
    */

    /* Inputs declaration */
    wire                CLK;
    wire                PCWrite;
    wire [31:0]         in;

    /* Initialization */
    initial begin
        
        out <= 32'd0;
    end

    /* Main function */ 
    always @(posedge CLK) begin
        if (PCWrite)
            out <= in;
        // $display("From PC. OUT: %32b", out);
    end

endmodule 

module IF_ID (
    input               CLK, 
    input               Write, 
    input [31:0]        PC_IN, 
    input [31:0]        INS_IN, 
    output reg [31:0]   PC_OUT, 
    output reg [31:0]   INS_OUT 
);
    /* Implementation Notes
    * --------------------
    * INPUTS:
    * CLK      ->      the clock signal
    * Write    ->      the control signal enables IF_ID to write
    * PC_IN    ->      input PC
    * INS_IN   ->      input binary code of the instruction fetched
    * OUTPUTS:
    * PC_OUT   ->      output PC
    * INS_OUT  ->      output instruction
    */

    /* Inputs declaration */
    wire                CLK;
    wire                Write;
    wire [31:0]         PC_IN;
    wire [31:0]         INS_IN;

    /* Main function */
    always @(posedge CLK) begin
        if (Write) begin
            PC_OUT <= PC_IN;
            INS_OUT <= INS_IN;
        end
    end

endmodule

module ID_EX (
    input               CLK, 
    input               MemtoReg, 
    input               RegWrite, 
    input               MemWrite, 
    input               MemRead, 
    input [1:0]         Branch, 
    input [3:0]         ALUControl,
    input               ALUSrc, 
    input               RegDst, 
    input [31:0]        readData1,
    input [31:0]        readData2, 
    input [31:0]        extendedData, 
    input [4:0]         IF_ID_RegisterRs,
    input [4:0]         IF_ID_RegisterRt, 
    input [4:0]         IF_ID_RegisterRd, 
    output reg          MemtoReg_OUT, 
    output reg          RegWrite_OUT, 
    output reg          MemWrite_OUT, 
    output reg          MemRead_OUT, 
    output reg [1:0]    Branch_OUT, 
    output reg [3:0]    ALUControl_OUT, 
    output reg          ALUSrc_OUT, 
    output reg          RegDst_OUT, 
    output reg [31:0]   readData1_OUT, 
    output reg [31:0]   readData2_OUT, 
    output reg [31:0]   extendedData_OUT, 
    output reg [4:0]    ID_EX_RegisterRs_OUT, 
    output reg [4:0]    ID_EX_RegisterRt_OUT, 
    output reg [4:0]    ID_EX_RegisterRd_OUT
);


    /* Inputs declaration */
    wire                CLK; 
    wire                MemtoReg; 
    wire                RegWrite; 
    wire                MemWrite; 
    wire                MemRead; 
    wire [1:0]          Branch; 
    wire [3:0]          ALUControl;
    wire                ALUSrc; 
    wire                RegDst; 
    wire [31:0]         readData1;
    wire [31:0]         readData2; 
    wire [31:0]         extendedData; 
    wire [4:0]          IF_ID_RegisterRs;
    wire [4:0]          IF_ID_RegisterRt; 
    wire [4:0]          IF_ID_RegisterRd; 


    /* Main  function */ 
    always @(posedge CLK) begin
        MemtoReg_OUT <= MemtoReg;
        RegWrite_OUT <= RegWrite;
        MemWrite_OUT <= MemWrite; 
        MemRead_OUT <= MemRead;
        Branch_OUT <= Branch;
        ALUControl_OUT <= ALUControl;
        ALUSrc_OUT <= ALUSrc;
        RegDst_OUT <= RegDst;
        readData1_OUT <= readData1;
        readData2_OUT <= readData2;
        extendedData_OUT <= extendedData;
        ID_EX_RegisterRs_OUT <= IF_ID_RegisterRs;
        ID_EX_RegisterRt_OUT <= IF_ID_RegisterRt;
        ID_EX_RegisterRd_OUT <= IF_ID_RegisterRd;
    end

endmodule

module EX_MEM (
    input               CLK, 
    input               MemtoReg, 
    input               RegWrite, 
    input               MemWrite, 
    input               MemRead, 
    input [31:0]        ALUResult, 
    input               ZERO, 
    input [31:0]        WriteData, 
    input [4:0]         ID_EX_RegisterRd, 
    output reg          MemtoReg_OUT, 
    output reg          RegWrite_OUT, 
    output reg          MemWrite_OUT, 
    output reg          MemRead_OUT, 
    output reg [31:0]   ALUResult_OUT, 
    output reg          ZERO_OUT, 
    output reg [31:0]   WriteData_OUT, 
    output reg [4:0]    EX_MEM_RegisterRd
); 

    /* Inputs declaration */ 
    wire                CLK;
    wire                MemtoReg;
    wire                RegWrite;
    wire                MemWrite;
    wire                MemRead;
    wire [31:0]         ALUResult;
    wire                ZERO;
    wire [31:0]         WriteData;
    wire [4:0]          ID_EX_RegisterRd;

    /* Main function */
    always @(posedge CLK) begin
        MemtoReg_OUT <= MemtoReg;
        RegWrite_OUT <= RegWrite;
        MemWrite_OUT <= MemWrite;
        MemRead_OUT <= MemRead;
        ALUResult_OUT <= ALUResult;
        ZERO_OUT <= ZERO;
        WriteData_OUT <= WriteData;
        EX_MEM_RegisterRd <= ID_EX_RegisterRd;
    end

endmodule 

module MEM_WB (
    input               CLK, 
    input               MemtoReg, 
    input               RegWrite, 
    input [31:0]        readData, 
    input [31:0]        ALUResult, 
    input [4:0]         EX_MEM_RegisterRd, 
    output reg          MemtoReg_OUT, 
    output reg          RegWrite_OUT, 
    output reg [31:0]   readData_OUT, 
    output reg [31:0]   ALUResult_OUT, 
    output reg [4:0]    MEM_WB_RegisterRd
);

    /* Inputs declaration */
    wire                MemtoReg;
    wire                RegWrite;
    wire [31:0]         readData;
    wire [31:0]         ALUResult;
    wire [4:0]          EX_MEM_RegisterRd;

    /* Main function */
    always @(posedge CLK) begin
        MemtoReg_OUT <= MemtoReg;
        RegWrite_OUT <= RegWrite;
        readData_OUT <= readData;
        ALUResult_OUT <= ALUResult;
        MEM_WB_RegisterRd <= EX_MEM_RegisterRd;
    end

endmodule 

`endif 