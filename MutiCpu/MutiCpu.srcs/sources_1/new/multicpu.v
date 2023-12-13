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
    output[31:0] instruction, //ȡ�õ�ָ��
    output[31:0] instcode, // ����ָ���ֵ
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
    output[1:0] pcsorce, //00ֱ��+4,01����������10��ֵrs��ֵ��11��תj
    output zero,    
    output pcwre,   //0Ϊpc�����ģ�1Ϊpc����
    output extsel,  //0Ϊ0��չ��1Ϊ1��չ
    output insmemrw, //0Ϊдָ��Ĵ�����1Ϊ��ָ��Ĵ���
    output [1:0] regdst, // д�Ĵ�����ĵ�ַ��00д31�żĴ�����01дrt��10дrd
    output regwre, // 1д��0��
    output alusrcA, // 0Ϊdata1�����1Ϊ��λsa
    output alusrcB, // 0Ϊdata2�����1λ��չ���������
    output[2:0] aluop,
    output mRd, // 1��ʱ������ݼĴ���
    output mWr, // 1��ʱ��д���ݼĴ���
    output dbdatasrc, // 0Ϊaluout�����1Ϊ������
    output wrereg, // 0д��pc+4,1д������ֵ
    output[31:0] writereg, //д��Ĵ����ĵ�ַ
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