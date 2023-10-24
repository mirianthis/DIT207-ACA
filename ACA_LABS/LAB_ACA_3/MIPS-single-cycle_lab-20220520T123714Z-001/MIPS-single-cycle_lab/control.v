module control(opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP);

input [5:0] opcode;

output reg RegDst;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg Branch;

output reg [1:0] AluOP;


always @(opcode) begin
case (opcode)

6'b000000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b100100_0_10; //r
6'b100011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b011110_0_00; //lw
6'b101011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'bx1x001_0_00; //sw
6'b000100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'bx0x000_1_01; //beq

6'b001100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b010100_0_10; //andi
6'b001101:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b010100_0_11; //ori
6'b001110:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b010100_0_00; //xori
6'b001000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b010100_0_00; //addi
6'b001010:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b010100_0_01; //slti
6'b000101:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b001001_1_01; //bne
6'b000110:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'bx0x0x0_0_01; //blez
6'b000111:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'bx0x0x0_0_01; //bgtz
6'b001111:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b010100_0_11; //lui

6'b000010:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP}=9'b000_000_0_00; //j
default: {RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,AluOP}=9'bxxx_xxx_x_xx;

endcase

end


endmodule
