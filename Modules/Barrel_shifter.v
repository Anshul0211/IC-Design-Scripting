`timescale 1ns / 1ps

module mux2x1(In1, In2, Sel, Out);
input In1, In2, Sel;
output Out;
wire g1, g2;
and(g1, In1, ~Sel);
and(g2, In2, Sel);
or(Out, g1, g2);
endmodule

module Barrel_shifter(Qin, Qout, Sel);
input [3:0]Qin;
output [3:0]Qout;
input [1:0]Sel;
wire [3:0]Pout;
mux2x1 stage1_1(Qin[3], Qin[1], Sel[1], Pout[3]);
mux2x1 stage1_2(Qin[2], Qin[0], Sel[1], Pout[2]);
mux2x1 stage1_3(Qin[1], 0, Sel[1], Pout[1]);
mux2x1 stage1_4(Qin[0], 0, Sel[1], Pout[0]);
mux2x1 stage2_1(Pout[3], Pout[2], Sel[0], Qout[3]);
mux2x1 stage2_2(Pout[2], Pout[1], Sel[0], Qout[2]);
mux2x1 stage2_3(Pout[1], Pout[0], Sel[0], Qout[1]);
mux2x1 stage2_4(Pout[0], 0, Sel[0], Qout[0]);
endmodule