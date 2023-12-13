`timescale 1ns / 1ps
module SegLED(
	input[3:0] Store,
	input Reset,
	output reg[6:0] Out
);
	always@(Store or Reset)begin
		if(Reset==0)begin
			Out=	8'b1111111;
		end
		else begin
			case(Store)
				4'b0000:	Out=	7'b0000001;	//0
				4'b0001:	Out=	7'b1001111;	//1
				4'b0010:	Out=	7'b0010010;	//2
				4'b0011:	Out=	7'b0000110;	//3
				4'b0100:	Out=	7'b1001100;	//4
				4'b0101:	Out=	7'b0100100;	//5
				4'b0110:	Out=	7'b0100000;	//6
				4'b0111:	Out=	7'b0001111;	//7
				4'b1000:	Out=	7'b0000000;	//8
				4'b1001:	Out=	7'b0000100;	//9
				4'b1010:	Out=	7'b0001000;	//A
				4'b1011:	Out=	7'b1100000;	//b
				4'b1100:	Out=	7'b0110001;	//C
				4'b1101:	Out=	7'b1000010;	//d
				4'b1110:	Out=	7'b0110000;	//E
				4'b1111:	Out=	7'b0111000;	//F
				default:	Out=	7'b0000000;	//all light
			endcase
		end
	end
endmodule
