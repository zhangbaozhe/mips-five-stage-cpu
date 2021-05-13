/* 
 * File Name: RegisterFile.v
 * Author:    ZHANG Baozhe
 * Date:      April , 2021
 * ----------------------------
 * This file implements the register
 * file in the CPU
 * 
 */

`ifndef _REGISTER_FILE
`define _REGISTER_FILE

module RegisterFile (
    input               CLK, 
    input               RegWrite, 
    input [25:21]       readReg1, 
    input [20:16]       readReg2,
    input [4:0]         writeReg,
    input [31:0]        writeData, 
    output reg [31:0]   readData1, 
    output reg [31:0]   readData2
 );
    /* 
    * Implementation Notes:
    * ---------------------------------------------------------
    * INPUTS:
    * CLK -> clock
    * RegWrite -> signal that enables writting to the register
    * readReg1 -> the number of the first reading register
    * readReg2 -> the number of the second reading register
    * writeReg -> the number of the register to write
    * writeData -> the data to write
    * OUTPUTS:
    * readData1 -> the content in the first register
    * readData2 -> the content in the second register
    */

    /* INPUTS Declaration */
    wire                CLK;
    wire                RegWrite;
    wire [25:21]        readReg1;
    wire [20:16]        readReg2;
    wire [31:0]         writeData;

    /* Temps Declaration */
    reg [31:0]          registers [0:31];
    reg [1024:0]        registers_init; /* 32 * 32 = 1024 */
    integer             i;

    /* Init */
    initial begin
        registers_init = {
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000}, 
            {32'b00000000000000000000000000000000} 
        };
        for (i = 0; i < 31; i++) begin
            registers[i] <= registers_init[i*32+:32];
        end
    end

    /* Main function */
    /* write register on posedge */
    always @(posedge CLK) begin
        if (RegWrite) begin
            registers[writeReg] <= writeData;
        end
    end

    always @(*) begin
        if ((readReg1 == writeReg) && RegWrite)
            readData1 = writeData;
        else 
            readData1 = registers[readReg1];
    end

    always @(*) begin
        if ((readReg2 == writeReg) && RegWrite)
            readData2 = writeData;
        else 
            readData2 = registers[readReg2];
    end

endmodule

`endif