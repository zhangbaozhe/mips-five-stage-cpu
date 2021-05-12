`include "MainMemory.v"

module MainMemory_tb;

    reg CLK;
    initial begin
        forever begin
            CLK = 0;
            #1 CLK = ~CLK;
        end
    end

    wire enable;
    assign enable = 1;


    wire [64:0] serial;
    wire [31:0] address;
    wire [31:0] data;


    MainMemory MEM (
        CLK, 
        1'b0, 
        enable, 
        address, 
        serial, 
        data
    );
    
    always @(posedge CLK) begin
        $display("I am running");
        serial = {{1'b1}, {32'h0000_0002}, {32'h0000_ffff}};
        #2;
        address = 32'h0000_0008 >> 2;
        #2;
        $display("%h", data);
        /* 
        assign serial = {{1'b1}, {32'h0000_0003}, {32'hffff_0000}};
        #2;
        assign address = 32'h0000_0003;
        #2;
        $display("%h", data);
        */ 
        $finish;
        
    end





endmodule 