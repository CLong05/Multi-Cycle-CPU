`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 17:31:59
// Design Name: 
// Module Name: pc
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


module pc(
    input clk,
    input reset,
    input pcwre,
    input[31:0] nextpc,
    output reg[31:0] curpc
);

    initial begin
        curpc <= 0;
    end
    
    always@(posedge clk or negedge reset) begin
        if(reset==0) begin
            curpc <= 0;
         end
        else begin
            if ( pcwre ) begin  //pcÐ´Ê¹ÄÜ
                curpc <= nextpc;
            end
            else begin
                curpc <= curpc;
            end
        end
    end

endmodule
