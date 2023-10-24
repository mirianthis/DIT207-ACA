module alucontrol(AluOp,FnField,AluCtrl);

input [1:0] AluOp;
input [5:0] FnField; //for R-type instructions

output reg [4:0] AluCtrl;


always@(AluOp or FnField)begin
casex({AluOp,FnField})

8'b00_xxxxxx:AluCtrl=5'b00010; //lw / sw
8'b01_000100:AluCtrl=5'b00011; //beq
8'b10_100000:AluCtrl=5'b00010; //add
8'b10_000010:AluCtrl=5'b00011; //sub
8'b10_100100:AluCtrl=5'b00000; //and
8'b10_100101:AluCtrl=5'b00001; //or
8'b10_101010:AluCtrl=5'b00100; //slt

8'b00_100111:AluCtrl=5'b00101; //nor
8'b01_100110:AluCtrl=5'b00110; //xor
8'b10_011000:AluCtrl=5'b00111; //mult
8'b10_011010:AluCtrl=5'b01000; //div
8'b1x_000000:AluCtrl=5'b01001; //sll
8'b1x_000010:AluCtrl=5'b01010; //srl
8'b1x_000011:AluCtrl=5'b01011; //sra
8'b01_000100:AluCtrl=5'b01100; //sllv
8'b1x_000110:AluCtrl=5'b01101; //srlv
8'b1x_001111:AluCtrl=5'b01110; //lui
8'b10_010010:AluCtrl=5'b01111; //mflo
8'b10_010000:AluCtrl=5'b10000; //mfhi
8'b01_000101:AluCtrl=5'b10001; //bne
8'b1x_000001:AluCtrl=5'b10010; //blez
8'b1x_000001:AluCtrl=5'b10011; //bgtz


endcase

end


endmodule
