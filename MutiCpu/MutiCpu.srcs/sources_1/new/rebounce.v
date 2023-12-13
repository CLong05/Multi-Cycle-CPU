//按键去抖动 
module rebounce(	input clk,	input rst_n,	input key_in,	output reg key_out);	
reg key_in0;
reg [19:0] cnt;
wire change;
parameter jitter=20'h2BF20;
// key_in0;
always@(posedge clk)
	if(!rst_n)
		key_in0<=0;
	else 
		key_in0<=key_in;	
assign change=(key_in & !key_in0)|(!key_in & key_in0);
// cnt
always@(posedge clk)
	if(!rst_n)
		cnt<=0;
	else if(change) cnt<=0;
	else cnt<=cnt+1;
// key_out
always@(posedge clk)
	if(!rst_n)
		key_out<=1;  //按键 不按下为1，按下为0；
	else if(cnt==jitter-1)
	key_out<=key_in;
	
endmodule

