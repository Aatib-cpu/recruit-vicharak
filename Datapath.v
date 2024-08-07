`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2024 01:06:09 AM
// Design Name: 
// Module Name: Datapath
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


module Datapath(
input clk,
input reset,
output [15:0] PC_F,
output [15:0] PC_D,
output [15:0] PC_Alu,
output [3:0] rd,
output [15:0] ALU_Result,Mem_Output,Data_Write
);

////////////////////////////////////////////////////////STAGE 1: Instruction Fetch//////////////////////////////////////
wire [15:0]PC_Out,PC_3,Branch_Address,PC_In;
wire [18:0]IR_IF;
wire Is_Address_Taken;
wire Do_Stall,MUX_ID_PM;

PC_Add_3 PA(PC_Out,PC_3);

PC_Mux PM(Is_Address_Taken,PC_3,Branch_Address,PC_In);

PC_Register PR(clk,reset,Do_Stall,PC_In,PC_Out); 

Instruction_Memory IM(clk,PC_Out,IR_IF);

////////////////////////////////////////////////////////STAGE 2: Instruction Decode//////////////////////////////////////
wire [18:0] IR_ID;
wire [15:0] PC_ID,Immediate_ID,Data_in_WB,Rout1_ID,Rout2_ID;
wire Read_Enable_1_ID,Read_Enable_2_ID,Write_Enable_ID,Stack_In_Enable_ID,Stack_Out_Enable_ID,R_Type_ID,I_Type_ID;
wire B_Type_Eq_ID,B_Type_Neq_ID,J_Type_ID,PS_Type_ID,Mem_WR_ID,Write_Enable_WB;
wire [3:0] Func_ID;
wire [1:0] Op1_Sel_ID,Op2_Sel_ID;
wire [3:0] rd_WB,rd_ID,rs1_ID,rs2_ID;
wire [1:0] MUX_IF_PM;

IF_ID_Reg FD(clk,reset,MUX_IF_PM,PC_Out,IR_IF,PC_ID,IR_ID);

Controller C(IR_ID,Immediate_ID,Read_Enable_1_ID,Read_Enable_2_ID,Write_Enable_ID,Stack_In_Enable_ID,Stack_Out_Enable_ID,
Op1_Sel_ID,Op2_Sel_ID,R_Type_ID,I_Type_ID,B_Type_Eq_ID,B_Type_Neq_ID,J_Type_ID,PS_Type_ID,Func_ID,Mem_WR_ID);

Reg_File RF(clk,reset,Data_in_WB,IR_ID,Write_Enable_WB,rd_WB,Read_Enable_1_ID,Read_Enable_2_ID,rd_ID,rs1_ID,rs2_ID,
Rout1_ID,Rout2_ID);

////////////////////////////////////////////////////////STAGE 3: Execution //////////////////////////////////////////////
wire [15:0] PC_EX,Immediate_EX,Rout1_EX,Rout2_EX,Op1_EX,Op2_EX,Result_EX,Stack_Out_EX;
wire Read_Enable_1_EX,Read_Enable_2_EX,Write_Enable_EX,Stack_In_Enable_EX,Stack_Out_Enable_EX,R_Type_EX,I_Type_EX;
wire B_Type_Eq_EX,B_Type_Neq_EX,J_Type_EX,PS_Type_EX,Mem_WR_EX,Empty,Full;
wire [3:0] Func_EX;
wire [1:0] Op1_Sel_EX,Op2_Sel_EX;
wire [3:0] rd_EX,rs1_EX,rs2_EX;
wire [15:0] Rout2_Fwd_EX,Rout1_Fwd_EX;

ID_EX_Reg DE(clk,reset,MUX_ID_PM,Read_Enable_1_ID,Read_Enable_2_ID,Write_Enable_ID,Mem_WR_ID,R_Type_ID,I_Type_ID,B_Type_Eq_ID,
B_Type_Neq_ID,J_Type_ID,PS_Type_ID,Stack_In_Enable_ID,Stack_Out_Enable_ID,PC_ID,Func_ID,rd_ID,rs1_ID,rs2_ID,Op1_Sel_ID,
Op2_Sel_ID,Rout1_ID,Rout2_ID,Immediate_ID,Read_Enable_1_EX,Read_Enable_2_EX,Write_Enable_EX,Mem_WR_EX,R_Type_EX,I_Type_EX,
B_Type_Eq_EX,B_Type_Neq_EX,J_Type_EX,PS_Type_EX,Stack_In_Enable_EX,Stack_Out_Enable_EX,PC_EX,Func_EX,rd_EX,rs1_EX,rs2_EX,
Op1_Sel_EX,Op2_Sel_EX,Rout1_EX,Rout2_EX,Immediate_EX);

Operand1_Mux O1M(Op1_Sel_EX,Rout1_Fwd_EX,PC_EX,Op1_EX);

Operand2_Mux O2M(Op2_Sel_EX,Rout2_Fwd_EX,Op2_EX);

ALU A(R_Type_EX,J_Type_EX,B_Type_Eq_EX,B_Type_Neq_EX,Func_EX,Op1_EX,Op2_EX,Result_EX,Is_Address_Taken);

Stack_Mem SM(clk,reset,Stack_In_Enable_EX,Stack_Out_Enable_EX,Result_EX,Empty,Full,Stack_Out_EX);

Branch_Mux BM(Stack_Out_Enable_EX,Stack_Out_EX,Immediate_EX,Branch_Address);

////////////////////////////////////////////////////////STAGE 4: Memory //////////////////////////////////////////////////
wire I_Type_Mem,Write_Enable_Mem,Mem_WR_Mem,Write_Back_Sel_Mem;
wire [3:0] rd_Mem;
wire [15:0] Immediate_Mem,Rout1_Mem,Result_Mem,Mem_Out_Mem;
wire [3:0] Func_Mem;

EX_MEM_Reg EM(clk,reset,I_Type_EX,Write_Enable_EX,rd_EX,Mem_WR_EX,Func_EX,Immediate_EX,Rout1_Fwd_EX,Result_EX,I_Type_Mem,
Write_Enable_Mem,rd_Mem,Mem_WR_Mem,Func_Mem,Immediate_Mem,Rout1_Mem,Result_Mem);


Data_Memory DM(clk,reset,I_Type_Mem,Mem_WR_Mem,Func_Mem,Immediate_Mem,Rout1_Mem,Mem_Out_Mem,Write_Back_Sel_Mem);

////////////////////////////////////////////////////////STAGE 4: Write Back /////////////////////////////////////////////
wire Write_Back_Sel_WB;
wire [15:0] Mem_Out_WB,Result_WB;

MEM_WB_Reg MW(clk,reset,Write_Back_Sel_Mem,Write_Enable_Mem,rd_Mem,Mem_Out_Mem,Result_Mem,Write_Back_Sel_WB,
Write_Enable_WB,rd_WB,Mem_Out_WB,Result_WB);

Write_Back_Mux WBM(Write_Enable_WB,Write_Back_Sel_WB,Mem_Out_WB,Result_WB,Data_in_WB);

////////////////////////////////////////////////////////Hazard Unit//////////////////////////////////////////////////////


Pipeline_Management PLM(rs1_ID,rs2_ID,Read_Enable_1_ID,Read_Enable_2_ID,rd_EX,Write_Enable_EX,I_Type_EX,Mem_WR_EX,
Is_Address_Taken,Do_Stall,MUX_IF_PM,MUX_ID_PM);

Forwarding_Unit FU(Rout1_EX,Rout2_EX,Read_Enable_1_EX,rs1_EX,Read_Enable_2_EX,rs2_EX,Write_Enable_Mem,rd_Mem,Result_Mem,
Write_Enable_WB,rd_WB,Write_Back_Sel_WB,Mem_Out_WB,Result_WB,Rout1_Fwd_EX,
Rout2_Fwd_EX);

///////////////////////////////////////////////////////Testbench Output//////////////////////////////////////////////////
assign PC_F = PC_Out;
assign PC_D = PC_ID;
assign PC_Alu = PC_EX;
assign rd = rd_WB;
assign ALU_Result = Result_EX;
assign Mem_Output = Mem_Out_Mem;
assign Data_Write = Data_in_WB;
endmodule
