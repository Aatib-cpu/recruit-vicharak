`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2024 12:55:26 AM
// Design Name: 
// Module Name: ID_EX_Reg
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

module ID_EX_Reg(
input clk,
input reset,
input MUX_ID_PM,//
input Read_Enable_1_ID, 
input Read_Enable_2_ID,
input Write_Enable_ID,
input Mem_WR_ID,
input R_Type_ID,
input I_Type_ID,
input B_Type_Eq_ID,
input B_Type_Neq_ID,
input J_Type_ID,
input PS_Type_ID,
input Stack_In_Enable_ID, 
input Stack_Out_Enable_ID,
input [15:0] PC_ID,
input [3:0] Func_ID,
input [3:0] rd_ID,
input [3:0] rs1_ID,
input [3:0] rs2_ID,
input [1:0] Op1_Sel_ID, 
input [1:0] Op2_Sel_ID,
input [15:0] Rout1_ID,
input [15:0] Rout2_ID,
input [15:0] Immediate_ID,

output reg Read_Enable_1_EX, 
output reg Read_Enable_2_EX,
output reg Write_Enable_EX,
output reg Mem_WR_EX,
output reg R_Type_EX,
output reg I_Type_EX,
output reg B_Type_Eq_EX,
output reg B_Type_Neq_EX,
output reg J_Type_EX,
output reg PS_Type_EX,
output reg Stack_In_Enable_EX, 
output reg Stack_Out_Enable_EX,
output reg [15:0] PC_EX,
output reg [3:0] Func_EX,
output reg [3:0] rd_EX,
output reg [3:0] rs1_EX,
output reg [3:0] rs2_EX,
output reg [1:0] Op1_Sel_EX, 
output reg [1:0] Op2_Sel_EX,
output reg [15:0] Rout1_EX,
output reg [15:0] Rout2_EX,
output reg [15:0] Immediate_EX
);

always@(posedge clk, posedge reset) begin
if (reset) begin
Read_Enable_1_EX <= 0; 
Read_Enable_2_EX <= 0;
Write_Enable_EX <= 0;
Mem_WR_EX <= 0;
R_Type_EX <= 0;
I_Type_EX <= 0;
B_Type_Eq_EX <= 0;
B_Type_Neq_EX <= 0;
J_Type_EX <= 0;
PS_Type_EX <= 0;
Stack_In_Enable_EX <= 0; 
Stack_Out_Enable_EX <= 0;
PC_EX <= 0;
Func_EX <= 0;
rd_EX <= 0;
rs1_EX <= 0;
rs2_EX <= 0;
Op1_Sel_EX <= 0; 
Op2_Sel_EX <= 0;
Rout1_EX <= 0;
Rout2_EX <= 0;
Immediate_EX <= 0;
end

else begin
if (MUX_ID_PM) begin //NOP:  ADD $0,$0,$0
Read_Enable_1_EX <= 1'b1; 
Read_Enable_2_EX <= 1'b1;
Write_Enable_EX <= 1'b1;
Mem_WR_EX <= 0;
R_Type_EX <= 1'b1;
I_Type_EX <= 0;
B_Type_Eq_EX <= 0;
B_Type_Neq_EX <= 0;
J_Type_EX <= 0;
PS_Type_EX <= 0;
Stack_In_Enable_EX <= 0; 
Stack_Out_Enable_EX <= 0;
PC_EX <= 0;
Func_EX <= 0;
rd_EX <= 0;
rs1_EX <= 0;
rs2_EX <= 0;
Op1_Sel_EX <= 2'b01; 
Op2_Sel_EX <= 2'b01;
Rout1_EX <= 0;
Rout2_EX <= 0;
Immediate_EX <= 0;
end
else begin //Normal
Read_Enable_1_EX <= Read_Enable_1_ID; 
Read_Enable_2_EX <= Read_Enable_2_ID;
Write_Enable_EX <= Write_Enable_ID;
Mem_WR_EX <= Mem_WR_ID;
R_Type_EX <= R_Type_ID;
I_Type_EX <= I_Type_ID;
B_Type_Eq_EX <= B_Type_Eq_ID;
B_Type_Neq_EX <= B_Type_Neq_ID;
J_Type_EX <= J_Type_ID;
PS_Type_EX <= PS_Type_ID;
Stack_In_Enable_EX <= Stack_In_Enable_ID; 
Stack_Out_Enable_EX <= Stack_Out_Enable_ID;
PC_EX <= PC_ID;
Func_EX <= Func_ID;
rd_EX <= rd_ID;
rs1_EX <= rs1_ID;
rs2_EX <= rs2_ID;
Op1_Sel_EX <= Op1_Sel_ID; 
Op2_Sel_EX <= Op2_Sel_ID;
Rout1_EX <= Rout1_ID;
Rout2_EX <= Rout2_ID;
Immediate_EX <= Immediate_ID;
end

end
//$display("PC_EX: %d",PC_EX);
//$display("rd_EX: %d",rd_EX);
//$display("rs1_EX: %d",rs1_EX);
//$display("rs2_EX: %d",rs2_EX);
//$display("Rout1_EX: %d",Rout1_EX);
//$display("Rout2_EX: %d",Rout2_EX);
//$display("Immediate_EX: %d",Immediate_EX);
end


endmodule