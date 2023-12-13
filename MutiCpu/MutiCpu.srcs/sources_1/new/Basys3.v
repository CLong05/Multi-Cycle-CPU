module Basys3(
	input CLK,
	input[2:0] SW,	//ѡ������ź�
	input Reset,	//���ð�ť
	input Button,	//������
	output reg[3:0] AN,	//�����λѡ���ź�
	output[6:0] Out	//����������ź�
);
	parameter T1MS=	50000;
	wire[31:0] nowpc;
        wire[31:0] newAddress;
        wire[31:0] instruction;//ȡ�õ�ָ��
        wire[31:0] instcode; // ����ָ���ֵ
        wire[5:0] op;
        wire[4:0] rs;
        wire[4:0] rt;
        wire[4:0] rd;
        wire[31:0] db;  
        wire[31:0] writedata;
        wire[31:0] rsout;
        wire[31:0] rtout;
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
        wire myclk;	
        reg[3:0] store;	//��¼��ǰҪ��ʾλ��ֵ	
        reg[16:0] showCounter;
        wire [2:0] state,nextstate;
        
        multicpu mcpu(myclk,Reset,nowpc,newAddress,instruction, instcode, op,rs,rt,rd,db,writedata,rsout,rtout,dataoutA,dataoutB,aluout,dataresult,pcsorce, zero,pcwre,extsel,insmemrw, regdst, regwre, alusrcA, alusrcB, aluop,mRd, mWr,dbdatasrc,wrereg,writereg,state,nextstate);
        rebounce reb(CLK,Reset,Button,myclk);        




	initial begin
		showCounter<=	0;
		AN<=	4'b0111;
	end
	always@(posedge CLK) begin
		if(Reset==0) begin
		  showCounter<=	0;
		  AN<=	4'b0000;
		end else begin
			showCounter<=	showCounter+1;
			if(showCounter==T1MS)
				begin
					showCounter<=	0;
					case(AN)
						4'b1110:	begin
							AN<=4'b1101;
						end
						4'b1101:	begin
							AN<=4'b1011;
						end
						4'b1011:	begin
							AN<=4'b0111;
						end
						4'b0111:	begin
							AN<=4'b1110;
						end
						4'b0000:	begin
							AN<=4'b0111;
					   end
					endcase
				end
			end
		end
	SegLED led(store,Reset,Out);
	always@(myclk)begin
	   case(AN)
			4'b1110:	begin
				case(SW)
					3'b000:	store<=	newAddress[3:0]; 3'b001:	store<=	rsout[3:0]; 3'b010:	store<=	rtout[3:0]; 3'b011:	store<=	writedata[3:0];3'b111: store<=	{1'b0,nextstate[2:0]};
				endcase
			end
			4'b1101:	begin
				case(SW)
					3'b000:	store<=	newAddress[7:4]; 3'b001:	store<=	rsout[7:4]; 3'b010:	store<=	rtout[7:4]; 3'b011:	store<=	writedata[7:4];3'b111: store<=	{4'b0000};
				endcase
			end
			4'b1011:	begin case(SW)
					3'b000:	store<=	nowpc[3:0]; 3'b001:	store<=	rs[3:0]; 3'b010:	store<=	rt[3:0]; 3'b011:	store<=	aluout[3:0];3'b111: store<=	{1'b0,state[2:0]};
				endcase
			end 
			4'b0111 : begin case(SW)
					3'b000: store<=	nowpc[7:4]; 3'b001: store<=	{3'b000,rs[4]}; 3'b010: store<=	{3'b000,rt[4]}; 3'b011: store<=	aluout[7:4];3'b111: store<=	{4'b0000};
				endcase
			end
		endcase
	end
endmodule
