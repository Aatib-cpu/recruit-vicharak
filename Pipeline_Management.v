`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2024 11:57:27 PM
// Design Name: 
// Module Name: Pipeline_Management
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

module Pipeline_Management(
input [3:0] rs1_ID, //rs1_ID
input [3:0] rs2_ID, //rs2_ID
input Read_Enable_1_ID, //Read_Enable_1_ID
input Read_Enable_2_ID, //Read_Enable_2_ID

input [3:0] rd_EX,   //rd_EX
input Write_Enable_EX, //Write_Enable_EX
input I_Type_EX, //I_Type_EX
input Mem_WR_EX, //Load

input Is_Address_Taken, //Is_Address_Taken
output reg Do_Stall, //Do_Stall
output reg [1:0] MUX_IF_PM, //01:NOP  10:Freeze 00:Normal
output reg MUX_ID_PM //1:NOP 0:Normal
);

wire I_Type_Load_EX;
assign I_Type_Load_EX=({I_Type_EX,Mem_WR_EX}==2'b10)?1:0;

//Stall Checking
always@(*) begin
if (Read_Enable_1_ID && Write_Enable_EX && I_Type_Load_EX && (rs1_ID == rd_EX)) //Checking with Rs1
    Do_Stall = 1'b1;
else if (Read_Enable_2_ID && Write_Enable_EX && I_Type_Load_EX && (rs2_ID == rd_EX)) //Checking with Rs2
    Do_Stall = 1'b1;
else
    Do_Stall = 1'b0;
end

//Piplenine Register MUX Control
always@(*) 
if (Is_Address_Taken) begin
    MUX_IF_PM = 2'b01; MUX_ID_PM = 1'b1; end //NOP  NOP
else if (Do_Stall) begin
    MUX_IF_PM = 2'b10; MUX_ID_PM = 1'b1; end //Freeze  NOP
else begin
    MUX_IF_PM = 2'b00; MUX_ID_PM = 1'b0; end //Normal Normal 


endmodule
