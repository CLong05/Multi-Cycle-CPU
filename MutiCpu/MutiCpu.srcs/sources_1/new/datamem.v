`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/17 15:50:51
// Design Name: 
// Module Name: datamem
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


module datamem(
    input mRd,
    input mWr,
    input dbdatasrc,
    input[31:0] aluout,
    input[31:0] dataB,
    output reg[31:0] dataout,
    output reg[31:0] db
);

    initial begin 
        dataout = 0;
        db = 0;
    end
    
    reg[7:0] datamemory[127:0];
    
    integer i;
    initial begin   //≥ı ºªØ∏≥÷µ
        for (i=0;i<128;i=i+1) datamemory[i] = 0;
    end    
    
    always@(mRd or aluout or dbdatasrc) begin
        if(mRd) begin
            dataout[7:0] = datamemory[aluout+3];
            dataout[15:8] = datamemory[aluout+2];
            dataout[23:16] = datamemory[aluout+1];
            dataout[31:24] = datamemory[aluout];
         end
         db = dbdatasrc?dataB:aluout;
    end
    
    always@(mWr or aluout) begin
        if (mWr) begin
            datamemory[aluout+3] <= dataB[7:0];
            datamemory[aluout+2] <= dataB[15:8];
            datamemory[aluout+1] <= dataB[23:16];
            datamemory[aluout] <= dataB[31:24];
        end
    end
    
endmodule
