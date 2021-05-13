/* 
 * File Name: Adder.v
 * Author:    ZHANG Baozhe
 * Date:      April , 2021
 * ----------------------------
 * This file implements the adder
 * in the CPU
 * 
 */

`ifndef _ADDER
`define _ADDER

module Adder (
    input [31:0]        data1, 
    input [31:0]        data2, 
    output reg [31:0]   result
);

    /* Inputs declaration */
    wire signed [31:0]  data1;
    wire signed [31:0]  data2;

    /* Main function */
    always @(*) begin
        result <= data1 + data2;
    end

endmodule
`endif