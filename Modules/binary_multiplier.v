`timescale 1ns / 1ps
module binary_multiplier(a,b,out);
parameter p=8;
parameter k=8;
input [p-1:0]a;
input [k-1:0]b;
reg [p+k-1:0]c;
output reg [p+k-1:0]out;
integer i;
integer j;

always @*
begin
out=0;
    for(i=0;i<p;i=i+1)
    begin
        c=0;
        if (b[i]==1)
            begin              
                c=a<<i;
            out=out+c;
            end
        else
        begin
        out=out;
        end
end   
end
endmodule