module alu(opA, opB, ALUop, shamt, result, zero, zero1);

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
		5'b00000: result = opA & opB;                        //AND
		5'b00001: result = opA | opB;                        //OR
		5'b00010: result = opA + opB;                        //ADD
		5'b00011: result = opA - opB;                        //SUB
		5'b00100: result = opA ^ opB;                        //XOR		
	    5'b00101: result = opB << shamt;                     //SLL
        5'b00110: result = opB >> shamt;                     //SRL
        5'b00111: result = $signed($signed(opB) >>> shamt);  //SRA
        5'b01000: result = opA < opB ? 1 : 0;                //SLT
        5'b01001: result = opA * opB;                        //MULT
        5'b01010: result = opA == opB;                       //BEQ
        5'b01011: result = opB << opA;                       //SLLV
        5'b01100: result = opB >> opA;                       //SRLV
        5'b01101: result = {opB[15:0], 16'b0};               //LUI
        5'b01110: result = opA / opB;                        //DIV
        5'b01111: result = hilo[63:32];                      //MFHI
        5'b10000: result = opA != opB;                       //BNE
        5'b10001: result = (opA < opB) | (opA == 0);         //BLEZ
        5'b10010: result = opA > opB;                        //BGTZ
        //5'b10011: result = ;                        //MFLO                         
	  
		
		
	endcase
end

endmodule
