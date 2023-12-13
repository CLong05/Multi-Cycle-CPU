`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 18:33:36
// Design Name: 
// Module Name: insmem
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


module insmem(
    input[31:0] curpc,
    input insmemrw, //0Ð´¼Ä´æÆ÷£¬1¶Á¼Ä´æÆ÷
    output reg[31:0] instruction
);
reg[7:0] insram[128:0];

initial begin
    $readmemb("C:/Users/86158/Desktop/test.txt",insram); 
end

always@(insmemrw or curpc ) begin

    if(insmemrw) begin
        instruction[7:0] = insram[curpc+3];
        instruction[15:8] = insram[curpc+2];
        instruction[23:16] = insram[curpc+1];
        instruction[31:24] = insram[curpc];
     end
end
endmodule
