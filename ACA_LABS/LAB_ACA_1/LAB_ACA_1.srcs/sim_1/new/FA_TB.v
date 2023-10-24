`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2022 05:19:09 PM
// Design Name: 
// Module Name: FA_TB
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


module FA_TB();

reg A, B, Cin;
wire Co, S;

FA FAt(.A(A), .B(B), .Cin(Cin), .Cout(Co), .Sum(S));



//integer k, l, m;
reg [2:0] k;
initial
begin

$monitor("A:%b, B:%b, Cin:%b --> S:%b Cout:%b", A, B, Cin, S, Co);
/*
for(k=0; k<=1; k=k+1) begin
    for(l=0; l<=1; l=l+1)begin        
        for(m=0; m<=1; m=m+1)begin
            #10 
                A = k;
                B = l;
                Cin = m;        
        end   
    end
end
*/

for(k=0; k<=7; k=k+1)
begin
#10 {A, B, Cin} = k;
end

end

endmodule
