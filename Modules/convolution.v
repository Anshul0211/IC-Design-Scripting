`timescale 1ns / 1ps

module convolution(matrix, kernel, clk, out);

parameter m = 10; //matrix size
parameter k = 3; //kernel size
input [8*m*m-1:0]matrix;
input [8*k*k-1:0]kernel;
input clk;
output reg[32*(m-k+1)*(m-k+1)-1:0]out; //considering each output value as 32 bit

reg [31:0]temp_out;
integer i, j;
integer row=0;
integer col=0;
reg [8*k*k-1:0]box;
reg [31:0]result[m-k:0][m-k:0];

always@(posedge clk)
begin

temp_out = 0; //resetting temporary sum register to 0 for each mac operation

//extracting the required 9 values into box:
for(i=0; i<k; i=i+1)
    begin
    for(j=0; j<k; j=j+1)
        begin
        box[8*(i*k + j)+:8] = matrix[8*((row+i)*m + (col+j))+:8];
        end
    end

//performing mac:
for(i=0; i<k*k; i=i+1)
    begin
    temp_out = temp_out + box[8*i+:8]*kernel[8*i+:8];
    end

//updating the results:
result[row][col] = temp_out;
out[32*(row*(m-k+1) + col)+:32] = result[row][col];

//incrementing row and column as per the conditions:
if(col==m-k+1)
    begin
    col=0;
    row=row+1;
    end
else
    col=col+1;

end

endmodule
