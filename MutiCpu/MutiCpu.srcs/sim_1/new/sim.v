`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/18 15:57:27
// Design Name: 
// Module Name: sim
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


module sim();
    reg clk;
    reg reset;
    wire[31:0] curpc;
    wire[31:0] nextpc;
    wire[31:0] instruction;//取得的指令
    wire[31:0] instcode; // 真正指令的值
    wire[5:0] op;
    wire[4:0] rs;
    wire[4:0] rt;
    wire[4:0] rd;
    wire[31:0] db;  
    wire[31:0] datadb;
    wire[31:0] dataA;
    wire[31:0] dataB;
    wire[31:0] dataoutA;
    wire[31:0] dataoutB;
    wire[31:0] aluout;
    wire[31:0] dataresult;
    wire[1:0] pcsorce;
    wire zero;    
    wire pcwre;   //0为pc不更改，1为pc更改
    wire extsel;  //0为0扩展，1为1扩展
    wire insmemrw; //0为写指令寄存器，1为读指令寄存器
    wire [1:0] regdst; // 写寄存器组的地址，00写31号寄存器，01写rt，10写rd
    wire regwre; // 1写，0读
    wire alusrcA; // 0为data1输出，1为移位sa
    wire alusrcB; // 0为data2输出，1位扩展后的立即数
    wire[2:0] aluop;
    wire mRd; // 1的时候读数据寄存器
    wire mWr; // 1的时候写数据寄存器
    wire dbdatasrc; // 0为aluout结果，1为立即数
    wire wrereg; // 0写入pc+4,1写入总线值
    wire[31:0] writereg ;//写入寄存器的地址
    wire [2:0] state,nextstate;
    multicpu mcpu(clk,reset,curpc,nextpc,instruction, instcode, op,rs,rt,rd,db,    datadb,dataA,dataB,dataoutA,dataoutB,aluout,dataresult,pcsorce, zero,    pcwre,   extsel,  insmemrw, regdst, regwre, alusrcA, alusrcB, aluop,mRd, mWr,dbdatasrc,wrereg,writereg,state,nextstate);
    
    initial begin
        clk = 0;
        reset = 0;
        #20;	//等待Reset完成
        clk=    !clk;    //下降沿，使PC先清零
        #20;
        reset=    1;    //清除保持信号
          forever #20 begin    //产生时钟信号，周期为20s
            clk=    !clk;
        end
     end
endmodule
