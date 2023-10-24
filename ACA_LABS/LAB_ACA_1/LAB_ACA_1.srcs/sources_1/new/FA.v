`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2022 04:22:33 PM
// Design Name: 
// Module Name: FA
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


module FA(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
    );
    
    assign Sum = (A^B) ^ Cin;
    assign Cout = ((A^B) & Cin) | (A&B);
    
    
endmodule
