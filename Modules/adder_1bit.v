`timescale 1ns / 1ps
module adder_1bit(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
wire x,y,z;

xor(sum,a,b,cin);
and(x,a,b);
and(y,b,cin);
and(z,a,cin);
or(cout,x,y,z);

endmodule
