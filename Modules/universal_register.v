module universal_register(Q, Load, Options, clk);
input [7:0]Load;
input clk;
output reg [7:0]Q;
input [2:0]Options;
reg a;

always @(posedge clk)
begin
if(Options==0) //load
    Q <= Load;
else if(Options==1) //no shift
    Q <= Q;
else if(Options ==2) //left shift 0 padded
    Q <= Q<<1;
else if(Options ==3) //rigth shift 0 padded
Q <= Q>>1;
else if(Options ==4) //circular right shift
    begin
    a=Q[0];
    Q <= Q>>1;
    Q[7]<=a;
    end
else if(Options ==5) //circular left shift
    begin
    a=Q[7];
    Q <= Q<<1;
    Q[0]<=a;
    end
else
    Q<=0; //reset Q to 0
end
endmodule
