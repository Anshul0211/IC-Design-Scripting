`timescale 1ns / 1ps

module sorter(A, B, C, outA, outB, outC);

input [7:0] A, B, C;
output reg [7:0] outA, outB, outC;
wire agb, bgc, agc, aeb, bec, aec;

comparator ab(.A(A), .B(B), .GT(agb), .LT(), .EQ(aeb));
comparator bc(.A(B), .B(C), .GT(bgc), .LT(), .EQ(bec));
comparator ac(.A(A), .B(C), .GT(agc), .LT(), .EQ(aec));

always@(*)
begin
if(agb || aeb)
    begin
    if(agc || aec)
        begin
        if(bgc || bec)
            begin
            outA=C; outB=B; outC=A;
            end
        else
            begin
            outA=B; outB=C; outC=A;
            end
        end
    else
        begin
        outA=B; outB=A; outC=C;
        end
    end
else
    begin
    if(bgc || bec)
        begin
        if(agc || aec)
            begin
            outA=C; outB=A; outC=B;
            end
        else
            begin
            outA=A; outB=C; outC=B;
            end
        end
    else
        begin
       
        outA=A; outB=B; outC=C;
        end
    end
end
endmodule
