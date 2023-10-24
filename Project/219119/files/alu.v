module alu(opA, opB, ALUop, result, zero, zero1, shamt);

input [31:0] opA;
input [31:0] opB;
input [4:0] ALUop;
input [4:0] shamt;

output reg [31:0] result;
output zero; //1 if result is 0
output reg zero1;
reg [63:0] hilo;

initial 
	begin
		zero1 = 0;
		hilo = 0;
	end

assign zero = (result==0);

always @(ALUop, opA, opB) begin
	case(ALUop)
		5'b00000: result= opA&opB; //and
		5'b00001: result= opA|opB; //or
		5'b00010: result= opA+opB; //add
		5'b00011: result= opA-opB; //sub
		5'b00100: result= opA<opB?1:0; //slt
		5'b00101: result= ~(opA|opB); //nor
		5'b00110: result= opA ^ opB; //xor
		5'b00111: result= opA * opB; //mult
		5'b01000: result= opA / opB; //div
		5'b01001: result= opB << shamt; //sll
		5'b01010: result= opB >> shamt; //srl
		5'b01011: result= $signed($signed(opB) >>> shamt); //sra 
		5'b01100: result= opB << opA; //sllv
		5'b01101: result= opB >> opA; //srlv
		5'b01110: result= {opB[15:0], 16'b0}; //lui
		5'b01111: result= hilo[31:0]; //mflo
		5'b10000: result= hilo[63:32]; //mfhi
		5'b10001: result= opA != opB; //bne
		5'b10011: result= opA <= 0; //blez
		5'b10100: result= opA > 0; //bgtz
	endcase
end

endmodule
