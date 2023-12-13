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
    wire[31:0] instruction;//ȡ�õ�ָ��
    wire[31:0] instcode; // ����ָ���ֵ
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
    wire pcwre;   //0Ϊpc�����ģ�1Ϊpc����
    wire extsel;  //0Ϊ0��չ��1Ϊ1��չ
    wire insmemrw; //0Ϊдָ��Ĵ�����1Ϊ��ָ��Ĵ���
    wire [1:0] regdst; // д�Ĵ�����ĵ�ַ��00д31�żĴ�����01дrt��10дrd
    wire regwre; // 1д��0��
    wire alusrcA; // 0Ϊdata1�����1Ϊ��λsa
    wire alusrcB; // 0Ϊdata2�����1λ��չ���������
    wire[2:0] aluop;
    wire mRd; // 1��ʱ������ݼĴ���
    wire mWr; // 1��ʱ��д���ݼĴ���
    wire dbdatasrc; // 0Ϊaluout�����1Ϊ������
    wire wrereg; // 0д��pc+4,1д������ֵ
    wire[31:0] writereg ;//д��Ĵ����ĵ�ַ
    wire [2:0] state,nextstate;
    multicpu mcpu(clk,reset,curpc,nextpc,instruction, instcode, op,rs,rt,rd,db,    datadb,dataA,dataB,dataoutA,dataoutB,aluout,dataresult,pcsorce, zero,    pcwre,   extsel,  insmemrw, regdst, regwre, alusrcA, alusrcB, aluop,mRd, mWr,dbdatasrc,wrereg,writereg,state,nextstate);
    
    initial begin
        clk = 0;
        reset = 0;
        #20;	//�ȴ�Reset���
        clk=    !clk;    //�½��أ�ʹPC������
        #20;
        reset=    1;    //��������ź�
          forever #20 begin    //����ʱ���źţ�����Ϊ20s
            clk=    !clk;
        end
     end
endmodule
