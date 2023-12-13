module Basys3(
	input CLK,
	input[2:0] SW,	//选择输出信号
	input Reset,	//重置按钮
	input Button,	//单脉冲
	output reg[3:0] AN,	//数码管位选择信号
	output[6:0] Out	//数码管输入信号
);
	parameter T1MS=	50000;
	wire[31:0] nowpc;
        wire[31:0] newAddress;
        wire[31:0] instruction;//取得的指令
        wire[31:0] instcode; // 真正指令的值
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
        wire myclk;	
        reg[3:0] store;	//记录当前要显示位的值	
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
