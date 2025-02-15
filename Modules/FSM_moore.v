`timescale 1ns / 1ps

module FSM_moore(In, Out, clk, reset, z);
parameter A=4'b0001;
parameter B=4'b0010;
parameter C=4'b0100;
parameter D=4'b1000;
parameter E=4'b0000;
parameter F=4'b1111;
input In, clk, reset;
output Out;
reg [3:0]y, Y;
output [5:0]z;

//output slow_clk;
//slowclk use2(.fast_clk(clk), .clk(slow_clk));

always @(In, y)
begin
case(y)
A: if (In==0)
Y=A;
else
Y=B;
B: if (In==0)
Y=C;
else
Y=B;
C: if (In==0)
Y=D;
else
Y=B;
D: if (In==0)
Y=A;
else
Y=E;
E: if (In==0)
Y=C;
else
Y=F;
F: if (In==0)
Y=C;
else
Y=B;
endcase
end

always @(posedge clk)
begin
if(!reset)
y<=A;
else
y<=Y;
end

assign Out=(y==4'b1111);
assign z[0] = (y==A);
assign z[1] = (y==B);
assign z[2] = (y==C);
assign z[3] = (y==D);
assign z[4] = (y==E);
assign z[5] = (y==F);

endmodule