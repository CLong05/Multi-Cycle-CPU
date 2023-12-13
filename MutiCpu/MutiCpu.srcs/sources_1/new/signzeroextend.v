`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 15:40:01
// Design Name: 
// Module Name: signzeroextend
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


module signzeroextend(
    input[15:0]immediate,
    input extsel,
    output[31:0] extimm
);

assign extimm[15:0] = immediate;
assign extimm[31:16] = extsel?(immediate[15]?16'hffff : 16'h0000) : 16'h0000;

endmodule
