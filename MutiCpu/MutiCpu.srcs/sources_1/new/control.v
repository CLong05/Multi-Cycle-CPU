`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 15:22:04
// Design Name: 
// Module Name: control
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


 module control(
    input clk,
    input reset,
    input zero,
    input[5:0] op,
    output reg IRwre,
    output reg pcwre,
    output reg extsel,
    output reg insmemrw,
    output reg wrereg,
    output reg[1:0] regdst,
    output reg regwre,
    output reg alusrcA,
    output reg alusrcB,
    output reg [1:0] pcsorce,
    output reg [2:0] aluop,
    output reg mRd,
    output reg mWr,
    output reg dbdatasrc,
    output reg[2:0] state,
    output reg[2:0] nextstate
);

   parameter[2:0] 
                   _add = 3'b000,
                   _sub = 3'b001,
                   _sltu = 3'b010,
                   _slt = 3'b011,
                   _sll = 3'b100,
                   _or = 3'b101,
                   _and = 3'b110,
                   _xor = 3'b111,
                   sif = 3'b000,
                   sid = 3'b001,
                   sexe = 3'b010,
                   smem = 3'b011,
                   swb = 3'b100,
                   inistate = 3'b111;
    parameter [5:0]              
                  sadd =	6'b000000,
                   ssub =   6'b000001,
                   sor  =  6'b100000,
                   sxori = 6'b010011,
                   ssll  =  6'b011000,
                   sand  =  6'b010000,
                   saddiu   = 6'b000010,
                   sori  =  6'b010010,
                   sbne  =  6'b110101,
                   sslt  =  6'b100111,
                   sslti =   6'b100110,
                   sbeq  =  6'b110100,
                   ssw =   6'b110000,
                   slw  =  6'b110001,
                   sbltz   = 6'b110110,
                   sandi  =  6'b010001,
                   sj =   6'b111000,
                   sjr =   6'b111001,
                   sjal =   6'b111010,
                  shalt  =  6'b111111;

    initial begin 
        state = inistate ;
        nextstate = sif;
        pcwre = 0;
        extsel = 0;
        IRwre = 0;
        insmemrw = 0;
        wrereg = 0;
        regdst = 2'b11;
        regwre =0;
        alusrcA = 0;
        alusrcB = 0;
        pcsorce = 2'b00;
        aluop = 3'b000;
        mRd = 0;
        mWr = 0;
        dbdatasrc = 0;
    end
    
    always@(posedge clk) begin
        if(reset==0) begin
            state <= inistate;
        end
        else begin
            state <= nextstate;
        end
    end
    
    always@( state or op or zero ) begin
        case (state) 
            inistate : nextstate = sif;
            sif : nextstate = sid;
            sid : 
                begin
                    case(op)
                        sj,sjr,sjal,shalt : nextstate = sif;
                        default : nextstate = sexe;
                    endcase
                end
             sexe :
                begin
                    case(op) 
                        sbeq,sbne,sbltz : nextstate = sif;
                        slw , ssw: nextstate = smem;
                        default : nextstate = swb;
                    endcase 
                end
              smem :
                begin
                    case(op)
                        slw : nextstate = swb;
                        default : nextstate = sif;
                     endcase
                 end
              swb :     nextstate = sif;
           endcase
           
          //IRwre  
           if (state == sif || nextstate == sid ) begin
             IRwre = 1;
          end
          else begin
            IRwre = 0;
          end
          
          //pcwre insmemrw
          if (nextstate == sif && op!= shalt && state != inistate) begin
            pcwre = 1;
            insmemrw = 1;
          end
          else begin
            pcwre = 0;
            insmemrw = 0;
          end 
           
           //alusrcA
           if ( op == ssll  ) begin
             alusrcA = 1;
           end
           else begin
             alusrcA = 0;
           end
           
           //alusrcB
           if ( op == sandi || op == sori|| op == sxori || op == saddiu  || op == sslti || op == ssw || op == slw ) begin
             alusrcB = 1;
           end
           else begin
             alusrcB = 0;
           end
           
           //dbdatasrc
           if ( op == slw ) begin
             dbdatasrc = 1;
           end
           else begin
             dbdatasrc = 0;
           end
           
           //regwre wrereg regdst
           if ( state == swb || state == sid && op == sjal ) begin
                regwre = 1;
                if ( op == sjal ) begin
                    regdst = 2'b00;
                    wrereg = 0;
                end
                else begin
                    wrereg = 1;
                    if ( op == sandi || op == sori || op == sxori || op == saddiu || op == sslti || op == slw) begin
                        regdst = 2'b01;
                    end
                    else begin
                        regdst = 2'b10;
                    end
                end
            end
            else begin
                regwre = 0;
            end
            
            //insmemrw
            if ( op != shalt ) begin
                insmemrw = 1;
            end
            else begin
                insmemrw = 0;
            end
            
            //mRd
            if (op == slw ) begin
                mRd = 1;
            end
            else begin
                mRd = 0;
            end
            
            //mWr
            if ( op == ssw ) begin
                mWr = 1;
            end
            else begin
                mWr = 0;
            end
            
            //extsel
            if ( op == saddiu || op == sbeq || op == sbne || op == sslti || op == sbltz || op == ssw || op == slw ) begin
                extsel = 1;
            end
            else begin
                extsel = 0;
            end
            
            //pcsorce //00直接+4,01加立即数，10赋值rs的值，11跳转j
            if ( op == sjr ) begin
                pcsorce = 2'b10;
            end 
            else if ( op == sbeq && zero == 1 || op == sbne && zero == 0 || op == sbltz && zero == 0 ) begin
                pcsorce = 2'b01;
            end
            else if ( op == sjal | op == sj ) begin
                pcsorce = 2'b11;
            end 
            else begin
                pcsorce = 2'b00;
            end
            
            //aluop
            case(op) 
                   sadd : aluop = _add;
                   ssub :aluop = _sub;
                   sor  :aluop = _or;
                   sxori :aluop = _xor;
                   ssll  :aluop = _sll;
                   sand :aluop = _and;
                   saddiu  :aluop = _add;
                   sori  :aluop = _or;
                   sbne  :aluop = _sub;
                   sslt  :aluop = _slt;
                   sslti :aluop = _slt;
                   sbeq  :aluop = _sub;
                   ssw :aluop = _add;
                   slw  :aluop = _add;
                   sbltz  :aluop = _sub;
                   sandi  :aluop = _and;
                   sj :aluop = _add;
                   sjr:aluop = _add;
                   sjal :aluop = _add;
                  shalt :aluop = _add;
            endcase
    end
endmodule
