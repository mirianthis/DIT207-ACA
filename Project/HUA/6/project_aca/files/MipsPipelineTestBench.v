module MipsPipelineTestBench();

reg clk, reset;
wire [31:0] nextPC, PCPlus4IF, PCPlus4ID, PCPlus4EX;
wire [31:0] branchAddress;
wire [31:0] instructionIF, instructionID;
wire [31:0] registerData1ID, registerData2ID, registerData1EX, registerData2EX;
wire [31:0] signExtendOutID, signExtendOutEX;
wire [31:0] shiftOut;
wire [3:0] ALUOpID, ALUOpEX;
wire [9:0] controlSignalsID;
wire [4:0] rsEX ,rtEX ,rdEX;
wire [31:0] ALUData1, ALUData2;
wire [31:0] ALUData2Mux_1Out;
wire [4:0] regDstMuxOut;
wire [31:0] ALUResultEX, ALUResultMEM, ALUResultWB;
wire [31:0] memoryWriteDataMEM;
wire [4:0] writeRegMEM, writeRegWB;
wire [1:0] upperMux_sel, lowerMux_sel;
wire [1:0] comparatorMux1Selector,comparatorMux2Selector;
wire [31:0] comparatorMux1Out, comparatorMux2Out;
wire [31:0] memoryReadDataMEM, memoryReadDataWB;
wire [31:0] regWriteDataMEM;
wire [3:0] ALUControl;


wire [31:0] Instruction;

wire [1:0] ALUOp;
wire [3:0] ALUCtrl;
wire [31:0] ALUout;
wire Zero;

wire [5:0] OpCode;
assign OpCode = Instruction[31:26];

wire [31:0] PC_adr;

wire [31:0] ReadRegister1;
wire [31:0] ReadRegister2;

wire [4:0] muxinstr_out;
wire [31:0] muxalu_out;
wire [31:0] muxdata_out;

wire [31:0] ReadData;

wire [31:0] signExtend;

wire PCsel;
wire [31:0] PC_adr;


//modules instances

//IF_Stage
pclogic PC(clk, reset, signExtend, PC_adr, PCsel); //generate PC
InstructionMemory instructionMemory(clk, readPC, instructionIF);
Adder PCAdder(PCPlus4IF ,readPC, 32'h00000004);
mux #(32) muxalu(AluSrc, ReadRegister2, signExtend, muxalu_out);//MUX for ALU
and branchAndComparator(PCMuxSel, equalFlag, branchID);
IF_ID_reg IF_ID(PCPlus4IF, instructionIF, instructionID, clk, holdIF_ID, PCPlus4ID, PCMuxSel);


//ID_Stage
control Control(OpCode,RegDst,ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp);
rf registerfile(clk,RegWrite,Instruction[25:21],Instruction[20:16],muxinstr_out, ReadRegister1, ReadRegister2, muxdata_out); //Registers
Mux3x1_32Bits comparatorMux1(comparatorMux1Out, registerData1ID, ALUResultMEM, regWriteDataMEM, comparatorMux1Selector);
Mux3x1_32Bits comparatorMux2(comparatorMux2Out, registerData2ID, ALUResultMEM, regWriteDataMEM, comparatorMux2Selector);
Comparator comparator(comparatorMux1Out, comparatorMux2Out, equalFlag);
signextend Signextend(signExtend, Instruction[15:0]); //Sign extend
ShiftLeft2 shiftLeft2(shiftOut, signExtendOutID);
Adder branchAdder(branchAddress, shiftOut, PCPlus4ID);
HazardDetectionUnit hazardUnit(MemReadEX, MemReadMEM, rtEX, instructionID, holdPC, holdIF_ID, hazardMuxSelector);
Mux2x1_10Bits ID_EXRegMux(controlSignalsID, {RegWriteID, MemtoRegID, MemWriteID, MemReadID, ALUSrcID, ALUOpID, RegDstID}
			,10'b0000000000, hazardMuxSelector);
ID_EX_reg ID_EX(RegWriteID, MemtoRegID, MemWriteID, MemReadID, ALUSrcID, ALUOpID, RegDstID, PCPlus4ID,registerData1ID ,registerData2ID
		,signExtendOutID,instructionID[25:11],PCPlus4EX ,registerData1EX ,registerData2EX ,signExtendOutEX ,rsEX ,rtEX ,rdEX
		,RegWriteEX,MemtoRegEX,MemWriteEX, MemReadEX,ALUSrcEX, ALUOpEX, RegDstEX,clk);


//EX_Stage
Mux3x1_32Bits ALUData1Mux(ALUData1, registerData1EX, regWriteDataMEM, ALUResultMEM, upperMux_sel);
Mux3x1_32Bits ALUData2Mux_1(ALUData2Mux_1Out, registerData2EX, regWriteDataMEM, ALUResultMEM, lowerMux_sel);
mux #(32) muxalu_0(AluSrc, ReadRegister2, signExtend, muxalu_out);//MUX for ALU
alucontrol AluControl(ALUOp, Instruction[5:0], ALUCtrl); //ALUControl
alu Alu(ReadRegister1, muxalu_out, ALUCtrl, ALUout, Zero); //ALU
mux #(5) muxinstr(RegDst, Instruction[20:16],Instruction[15:11],muxinstr_out);
EX_MemReg EX_MEM(clk, RegWriteEX, MemtoRegEX, MemWriteEX, MemReadEX, ALUResultEX, ALUData2Mux_1Out
		,regDstMuxOut, RegWriteMEM, MemtoRegMEM, MemWriteMEM, MemReadMEM, ALUResultMEM, memoryWriteDataMEM, writeRegMEM);
ForwardingUnit forwardingUnit(RegWriteMEM, writeRegMEM, RegWriteWB, writeRegWB, rsEX, rtEX
				,upperMux_sel,lowerMux_sel, comparatorMux1Selector,comparatorMux2Selector);


//MEM_Stage
DataMemory dataMemory(MemWriteMEM, MemReadMEM, ALUResultMEM, memoryWriteDataMEM, clk, memoryReadDataMEM);
Mem_WbReg MEM_WB(RegWriteMEM, MemtoRegMEM, ALUResultMEM, clk, memoryReadDataMEM, writeRegMEM, RegWriteWB, MemtoRegWB,memoryReadDataWB
		,ALUResultWB, writeRegWB);


//WB_Stage
mux #(32) muxdata(MemtoReg, ALUout, ReadData, muxdata_out); //MUX for Data memory



//pc updated, change in singel cycle testbench
always@(clk)
#100 clk <= ~clk;

initial
begin

clk <= 0;
reset <= 1;
#50
reset <= 0;

end

endmodule
