`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2022 04:17:11 PM
// Design Name: 
// Module Name: decoder_tb
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


module decoder_tb();

wire [7:0] dec38o;
wire [15:0] dec416o;

reg [2:0] dec38i;
reg [3:0] dec416i;

decoder #(3, 8) dec38(dec38i, dec38o);
decoder #(4, 16) dec416(dec416i, dec416o);

initial begin

    #0 dec38i = 0;
    dec416i = 0;

    $monitor("IN4: %4b --> OUT16: %16b | IN3: %3b --> OUT8: %8b", dec416i, dec416o, dec38i, dec38o);
end

always
begin
    #20 dec38i = dec38i + 1;
end

always
begin
    #20 dec416i = dec416i + 1;
end

endmodule