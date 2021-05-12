/* 
 * File Name: cpu_tb.v
 * Author:    ZHANG Baozhe
 * Date:      May , 2021
 * ----------------------------
 * This file is the core part of this project in which it connects
 * all other parts. In this file, a clock is constructed, the modules
 * are connected, and some I/O about files may be concerned.
 *  
 */

`include "CPU.v"

module top_module;
    reg CLK;
    initial begin
        forever begin
            CLK = 0;
            #1 CLK = ~CLK;
        end
    end

    CPU _cpu (CLK);



endmodule 