`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 15:28:31
// Design Name: 
// Module Name: pcadd
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


module pcadd(
    //生成下一条指令
    input reset,
    input clk,
    input[1:0] pcsorce, //00直接+4,01加立即数，10赋值rs的值，11跳转j
    input[31:0] extimm,
    input[25:0] jumpaddr,
    input[31:0] curpc,
    input[31:0] dataoutA,
    output reg[31:0] nextpc 
);

    initial begin
        nextpc = 0;
    end
    
    reg[31:0] pc;
    
    always@(*) begin
        if(reset==0) begin
            nextpc = 0;
        end
        else begin
            pc = curpc+4;
            case(pcsorce) 
            2'b00: nextpc = curpc + 4;
            2'b01: nextpc = curpc + 4 + extimm*4;
            2'b10: nextpc = dataoutA;
            2'b11: nextpc = {pc[31:28],jumpaddr,2'b00};
            endcase
         end
    end 
endmodule
