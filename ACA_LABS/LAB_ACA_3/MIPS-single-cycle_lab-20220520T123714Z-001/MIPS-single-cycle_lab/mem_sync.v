module mem_sync(clk,a,dout, din, mread, mwrite);
//synchronous memory with 256 32-bit locations
//for data memory
parameter S=32; //size
parameter L=256; //length

input [$clog2(L) - 1:0] a;
input [S-1:0] din;
input clk;
input mwrite;
input mread;
output [(S-1):0] dout;

reg [S-1:0] memory [L-1:0];


assign dout=memory[a];
always @(posedge clk) begin
if (mwrite==1) begin
memory[a]<=din;

end

end

initial $readmemh("C:/Users/miria/OneDrive/Υπολογιστής/HUA/6ο ΕΞΑΜΗΝΟ/Σύγρονες Αρχιτεκτονικές Υπολογιστών/ACA_LABS/LAB_ACA_3/MIPS-single-cycle_lab-20220520T123714Z-001/MIPS-single-cycle_lab/memdata.dat", memory);

endmodule
