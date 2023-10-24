`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2022 05:22:14 PM
// Design Name: 
// Module Name: arbiter
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


module arbiter(out, in0, in1, in2, in3);

input [6:0] in0, in1, in2, in3;
output reg [1:0] out;

wire [6:0] m0win, m1win;
reg c1gt2, c3gt2;

always @(*) begin
if (in1 > in0)
    c1gt2 = 1;
else
    c1gt2 = 0;
end

assign m0win = (c1gt2)? in1 : in0;

always @(*) begin
if (in3 > in2)
    c3gt2 = 1;
else
    c3gt2 = 0;
end

assign m1win = (c3gt2)? in3 : in2;

always @(*) begin
if (m1win > m0win)
    out[1] = 1;
else
    out[1] = 0;
end

always @(*) begin
if (out[1] == 0)
    out[0] = c3gt2;
else
    out[1] = c1gt2;
end

endmodule
