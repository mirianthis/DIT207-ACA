`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2022 05:56:02 PM
// Design Name: 
// Module Name: m_bit_reg
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


module m_bit_reg(d, clk, rst, q);

parameter M = 16;

input [M-1:0] d;
input clk;
input rst;
output reg [M-1:0] q;

always @(posedge clk)
begin
    if (rst)
        q <= 0;
    else
        q <= d;
end

endmodule

