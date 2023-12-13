`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/17 15:45:30
// Design Name: 
// Module Name: ALU
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


module ALU(
    input alusrcA,
    input alusrcB,
    input[31:0] dataA,
    input[31:0] dataB,
    input[4:0] sa,
    input[31:0] extimm,
    input[2:0] aluop,
    output reg zero,
    output reg[31:0] aluout
);

    initial begin
        aluout = 0;
    end 
  
    parameter[2:0] 
                    _add = 3'b000,
                    _sub = 3'b001,
                    _sltu = 3'b010,
                    _slt = 3'b011,
                    _sll = 3'b100,
                    _or = 3'b101,
                    _and = 3'b110,
                    _xor = 3'b111;

    reg[31:0] a;
    reg[31:0] b;
    
    initial begin 
        aluout = 0;
        zero = 0;
    end
    
    always@(alusrcA or alusrcB or dataA or dataB or aluop ) begin
        a = alusrcA? sa : dataA;
        b = alusrcB?  extimm:dataB;
        case (aluop) 
            _add : aluout = a+b;
            _sub : aluout = a-b;
            _sltu : aluout = a<b? 1 : 0;
            _slt : aluout = a[31] != b[31] ? a[31] > b[31] : a < b;
            _sll : aluout = b << a;
            _or : aluout = a | b;
            _and : aluout = a & b;
            _xor : aluout = a ^ b;
        endcase 
            zero = aluout==0? 1 : 0;
    end

endmodule