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

    integer cycle = 0;
    reg CLK = 0;
    initial begin
        forever begin
            #1 CLK = ~CLK;
            if (CLK)
                cycle = cycle + 1;
            // $display(CLK);
        end
    end
    initial
    begin
        file = $fopen("RAM_OUTPUT", "w");
        //$dumpfile("cpu_tb.vcd");
        //$dumpvars(0, _cpu);
    end

    CPU _cpu (CLK);
    integer i, file;
    
    always @(*) begin
        if (_cpu._ins_ram.DATA == 32'hffff_ffff) begin
            $display("CYCLE: \t %d", cycle + 4);
            #10 
            $display("ADDRESS \t DATA \t");
            for (i = 0; i < 511; i = i+1) begin
                $display("%x \t %b \t", 
                i * 4, 
                _cpu._mem.DATA_RAM[i]);
                $fdisplayb(file, _cpu._mem.DATA_RAM[i]);
            end
            $fclose(file);
            $finish;
        end 
    end



endmodule 