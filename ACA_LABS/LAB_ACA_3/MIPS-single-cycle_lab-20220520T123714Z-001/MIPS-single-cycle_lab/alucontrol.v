module alucontrol(AluOp,FnField,AluCtrl);

input [1:0] AluOp;
input [5:0] FnField; //for R-type instructions

output reg [4:0] AluCtrl;


always@(AluOp or FnField)begin
    casex({AluOp,FnField})
        8'b00_xxxxxx:AluCtrl=5'b00010; //lw / sw
        8'b01_xxxxxx:AluCtrl=5'b00011; //beq
        8'b1x_xx0000:AluCtrl=5'b00010; //add
        8'b1x_xx0010:AluCtrl=5'b00011; //sub
        8'b1x_xx0100:AluCtrl=5'b00000; //and
        8'b1x_xx0101:AluCtrl=5'b00001; //or
        8'b1x_101010:AluCtrl=5'b01000; //slt
        
        8'b10_011010:AluCtrl=5'b01110; //div
        8'b10_011000:AluCtrl=5'b01001; //mult
        8'b1x_001111:AluCtrl=5'b01101; //luc       
        8'b1x_xx0110:AluCtrl=5'b00100; //xor       
        8'b00_000000:AluCtrl=5'b00101; //sll
        8'b00_000010:AluCtrl=5'b00110; //srl
        8'b00_000011:AluCtrl=5'b00111; //sra        
        8'b00_xx0100:AluCtrl=5'b01011; //sllv
        8'b00_xx0110:AluCtrl=5'b01100; //srlv
        8'b1x_xx0111:AluCtrl=5'b01111; //nor
        8'b00_010000:AluCtrl=5'b01010; //mfhi
        8'b01_xxxxxx:AluCtrl=5'b10000; //bne
        8'b01_xxxxxx:AluCtrl=5'b10001; //blez
        8'b01_xxxxxx:AluCtrl=5'b10010; //bgtz
        //8'b1x_010010:AluCtrl=5'b10011; //mflo

        
     endcase
end
endmodule
