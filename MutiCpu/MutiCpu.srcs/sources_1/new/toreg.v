`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/18 21:43:18
// Design Name: 
// Module Name: toreg
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


module toreg(
    input clk,
    input reset,
    input[31:0] datain,
    output reg[31:0] dataout
);
    
initial begin
    dataout = 0;
end


always@(posedge clk) begin
    if (reset==0) begin
        dataout<=0;
    end
    else begin
        dataout <= datain;
    end
end

endmodule

