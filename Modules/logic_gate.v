`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2024 07:52:48
// Design Name: 
// Module Name: lab1_1a
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


module lab1_1a(A, B, C, D, OUT);
input A,B,C,D;
output OUT;
wire x,y,z;
    //f=~B~C~D + ~ABD + BC
    and (x, ~B, ~C, ~D);
    and (y, D, ~A, B);
    and (z, C, B);
    or (OUT, x, y, z);
    
endmodule
