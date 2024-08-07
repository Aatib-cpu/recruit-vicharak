module Forwarding_Unit(
//Operand inputs from Decode stage (Stage 2)
input [15:0] Rout1_EX,
input [15:0] Rout2_EX,

input Read_Enable_1_EX,        //rs1 Validity after Decode
input [3:0] rs1_EX,              //rs1 after Decode

input Read_Enable_2_EX,        //rs1 Validity after Decode
input [3:0] rs2_EX,           //rs1 after Decode

//Forwarding from execution (after stage3)
input Write_Enable_Mem,         //rd_Valid execute
input [3:0] rd_Mem,         //rd after execute
input [15:0] Result_Mem,       //Alu from execute

//Forwarding from memory (after stage4)
input Write_Enable_WB,          //rd_Valid after stage 4 
input [3:0] rd_WB,          //rd after after stage 4 
input Write_Back_Sel_WB,            //Load Type format after stage 4 //I_Type_Load_MEM
input [15:0] Mem_Out_WB,    //Load from memory
input [15:0] Result_WB,       //Alu after stage 4

//Forwarding Outputs
output reg [15:0] Rout1_Fwd_EX,
output reg [15:0] Rout2_Fwd_EX
);


//For Rout1_Fwd_EX 
always@(*)
if (Read_Enable_1_EX&&Write_Enable_Mem&&(rs1_EX==rd_Mem)&&(rs1_EX!=0))
    Rout1_Fwd_EX = Result_Mem;//Dependence on ALU output
else if (Read_Enable_1_EX&&Write_Enable_WB&&(rs1_EX == rd_WB)&&(rs1_EX!=0)&&Write_Back_Sel_WB)
    Rout1_Fwd_EX = Mem_Out_WB; //Dependence on Loaded data
else if (Read_Enable_1_EX&&Write_Enable_WB&&(rs1_EX == rd_WB)&&(rs1_EX!=0)) 
    Rout1_Fwd_EX = Result_WB; //Dependence on write back data
else
    Rout1_Fwd_EX = Rout1_EX; 


//For Rout2_Fwd_EX
always@(*)
if (Read_Enable_2_EX&&Write_Enable_Mem&&(rs2_EX == rd_Mem)&&(rs2_EX!=0))
    Rout2_Fwd_EX = Result_Mem;
else if (Read_Enable_2_EX&&Write_Enable_WB &&(rs2_EX == rd_WB)&&(rs2_EX!=0)&&Write_Back_Sel_WB)
    Rout2_Fwd_EX = Mem_Out_WB;
else if (Read_Enable_2_EX&&Write_Enable_WB &&(rs2_EX == rd_WB)&&(rs2_EX!=0))
    Rout2_Fwd_EX = Result_WB;
else
    Rout2_Fwd_EX = Rout2_EX;

//always@(*) begin
//$display("\n Forwarding unit");
//$display("Read_Enable_1_EX: %b ",Read_Enable_1_EX);
//$display("rs1_EX: %b ",rs1_EX);
//$display("Read_Enable_2_EX: %b ",Read_Enable_2_EX);
//$display("rs2_EX: %b ",rs2_EX);
//$display("Write_Enable_Mem: %b ",Write_Enable_Mem);
//$display("rd_Mem: %b ",rd_Mem);
//$display("rd_WB: %b ",rd_WB);
//$display("Rout1_Fwd_EX: %d ",Rout1_Fwd_EX);
//$display("Rout2_Fwd_EX: %d ",Rout2_Fwd_EX);
//$display("Rout1_EX: %d ",Rout1_EX);
//$display("Rout2_EX: %d ",Rout2_EX);
//$display("Result_Mem: %d",Result_Mem);
//$display("Mem_Out_WB: %d",Mem_Out_WB);
//$display("Result_WB: %d",Result_WB);
//end   
endmodule