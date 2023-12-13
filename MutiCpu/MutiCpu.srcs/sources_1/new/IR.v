`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 19:36:57
// Design Name: 
// Module Name: IR
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


module IR(
    input[31:0] instruction,
    input clk,
    input reset,
    input IRwre, // 写使能，1为写入
    output reg[31:0] instcode
);

initial begin
    instcode = 0;
end

always@(posedge clk) begin
    if (reset==0) begin
        instcode <= 0;
    end
    else begin
        if(IRwre) begin
            instcode = instruction;
        end
    end
end

endmodule
