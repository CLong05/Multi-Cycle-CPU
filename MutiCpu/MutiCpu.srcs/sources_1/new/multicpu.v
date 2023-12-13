`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 15:20:08
// Design Name: 
// Module Name: multicpu
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


module multicpu(
    input clk,
    input reset,
    output[31:0] curpc,
    output[31:0] nextpc,
    output[31:0] instruction, //取得的指令
    output[31:0] instcode, // 真正指令的值
    output[5:0] op,
    output[4:0] rs,
    output[4:0] rt,
    output[4:0] rd,
    output[31:0] db,    
    output[31:0] datadb,
    output[31:0] dataA,
    output[31:0] dataB,
    output[31:0] dataoutA,
    output[31:0] dataoutB,
    output[31:0] aluout,
    output[31:0] dataresult,
    output[1:0] pcsorce, //00直接+4,01加立即数，10赋值rs的值，11跳转j
    output zero,    
    output pcwre,   //0为pc不更改，1为pc更改
    output extsel,  //0为0扩展，1为1扩展
    output insmemrw, //0为写指令寄存器，1为读指令寄存器
    output [1:0] regdst, // 写寄存器组的地址，00写31号寄存器，01写rt，10写rd
    output regwre, // 1写，0读
    output alusrcA, // 0为data1输出，1为移位sa
    output alusrcB, // 0为data2输出，1位扩展后的立即数
    output[2:0] aluop,
    output mRd, // 1的时候读数据寄存器
    output mWr, // 1的时候写数据寄存器
    output dbdatasrc, // 0为aluout结果，1为立即数
    output wrereg, // 0写入pc+4,1写入总线值
    output[31:0] writereg, //写入寄存器的地址
    output [2:0] state,
    output [2:0] nextstate
    );
    wire[31:0] extimm;
    wire[31:0] dataout;
    wire[4:0] sa;
    wire[15:0]immediate;
    wire[25:0] jumpaddr;
    wire IRwre;
    control cu(clk,reset,zero,op,IRwre,pcwre,extsel,insmemrw,wrereg,regdst,regwre,alusrcA,alusrcB,pcsorce,aluop,mRd,mWr,dbdatasrc,state,nextstate);
    pcadd pcadd(reset,clk,pcsorce,extimm,jumpaddr,curpc,dataoutA,nextpc);
    pc pc(clk,reset,pcwre,nextpc,curpc);
    insmem ins(curpc,insmemrw,instruction);
    IR ir(instruction,clk,reset,IRwre,instcode);
    cut cut(clk,reset,instcode,op,rs,rt,rd,sa,immediate,jumpaddr);
    signzeroextend extend(immediate,extsel,extimm);
    registerfile rgfile(clk,reset,rs,rt,rd,wrereg,datadb,curpc,regdst,regwre,dataoutA,dataoutB,writereg);
    toreg writeA(clk,reset,dataoutA,dataA);
    toreg writeB(clk,reset,dataoutB,dataB);
    ALU alu(alusrcA,alusrcB,dataA,dataB,sa,extimm,aluop,zero,aluout);
    toreg getresult(clk,reset,aluout,dataresult);
    datamem dm(mRd,mWr,dbdatasrc,aluout,dataB,dataout,db);
    toreg getdb(clk,reset,db,datadb);
endmodule