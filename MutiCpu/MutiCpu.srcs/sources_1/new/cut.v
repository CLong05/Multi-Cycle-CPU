`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 20:38:46
// Design Name: 
// Module Name: cut
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cut(
    input clk,
    input reset,
    input[31:0] instcode,
    output reg[5:0]op,
    output reg[4:0] rs,
    output reg[4:0] rt,
    output reg[4:0] rd,
    output reg[4:0] sa,
    output reg[15:0] immediate,
    output reg[25:0] jumpaddr
);

    initial begin 
        op = 0;
        rs = 0;
        rt = 0;
        rd = 0;
        sa = 0;
        immediate = 0;
        jumpaddr = 0;
    end
    
    always@(instcode) 
    begin
        op = instcode[31:26];
        rs = instcode[25:21];
        rt = instcode[20:16];
        rd = instcode[15:11];
        sa = instcode[10:6];
        immediate = instcode[15:0];
        jumpaddr = instcode[25:0];
    end

endmodule
