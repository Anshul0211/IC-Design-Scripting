`timescale 1ns / 1ps

module shifter(Qin, Qout, Sel, clk);

input [3:0]Qin;
input [1:0]Sel;
input clk;
output reg [3:0]Qout;

always@(posedge clk)
begin
case(Sel)
    0: 
    Qout=Qin;
    1:
    begin
    Qout[3]<=Qin[2];
    Qout[2]<=Qin[1];
    Qout[1]<=Qin[0];
    Qout[0]<=0;
    end
    2:
    begin
    Qout[3]<=Qin[1];
    Qout[2]<=Qin[0];
    Qout[1]<=0;
    Qout[0]<=0;
    end
    3:
    begin
    Qout[3]<=Qin[0];
    Qout[2]<=0;
    Qout[1]<=0;
    Qout[0]<=0;
    end

endcase
end

endmodule
