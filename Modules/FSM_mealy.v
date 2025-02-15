`timescale 1ns / 1ps

module FSM_mealy(In, Out, clk, reset, z);

parameter A=4'b0001;
parameter B=4'b0010;
parameter C=4'b0100;
parameter D=4'b1000;
parameter E=4'b0000;

input In, clk, reset;
output reg Out;
output [4:0]z;
reg [3:0]y,Y;

//wire slow_clk;
//slowclk use1(.fast_clk(clk), .clk(slow_clk));

always @(In, y)
begin
case(y)
    A: if (In==0) begin
        Y=A; Out=0;
    end
    else
    begin
    Y=B; Out=0;
    end
    B: if(In==0) begin
        Y=C; Out=0;
    end
    else
    begin
    Y=B; Out=0;
    end
    C: if (In==0) begin
        Y=D; Out=0;
    end
    else
    begin
    Y=B; Out=0;
    end
    D: if(In==0) begin
        Y=A; Out=0;
    end
    else
    begin
    Y=E; Out=0;
    end
    E: if(In==0) begin
        Y=C; Out=0;
    end
    else
    begin
    Y=B; Out=1;
    end
endcase
end

always @(posedge clk)
begin
    if(!reset)
    begin
    y<=A;
    end
    else
    y<=Y;
end

assign z[0] = (y==A);
assign z[1] = (y==B);
assign z[2] = (y==C);
assign z[3] = (y==D);
assign z[4] = (y==E);

endmodule
