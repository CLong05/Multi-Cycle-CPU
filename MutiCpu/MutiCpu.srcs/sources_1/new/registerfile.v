`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 16:41:22
// Design Name: 
// Module Name: registerfile
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


module registerfile(
    input clk,
    input reset,
    input[4:0] rs,
    input[4:0] rt,
    input[4:0] rd,
    input wrereg,
    input[31:0] datadb,
    input[31:0] curpc,
    input[1:0] regdst,
    input regwre,
    output reg[31:0] dataoutA,
    output reg[31:0] dataoutB,
    output reg[31:0] writereg
);

    initial begin 
        dataoutA <= 0;
        dataoutB <= 0;
        writereg <= 0;
        
    end

    reg[31:0] regfile[0:31];
    integer i;
    //初始时，将32个寄存器和ReadData全部赋值为0
    initial begin
        for (i=0;i<32;i=i+1) regfile[i] = 0;
    end
    always@(rs or rt) begin
            dataoutA = regfile[rs];
            dataoutB = regfile[rt];
    end
     always@(*) begin
        case(regdst) 
            2'b00 : writereg = 31;
            2'b01 : writereg = rt;
            2'b10 : writereg = rd;
        endcase
    end   
    always@(negedge clk) begin
        if (reset==0) begin
            for (i=0;i<32;i=i+1) regfile[i] <= 0;
            
        end
        if( regwre && writereg ) begin
            if ( wrereg ) begin
                regfile[writereg] <= datadb;
            end
            else begin
                regfile[writereg] <= curpc+4;
            end
        end
    end
 
endmodule
