`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2024 11:33:36 PM
// Design Name: 
// Module Name: Write_Back_Mux
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

module Write_Back_Mux(
input Write_Enable_WB,
input Write_Back_Sel_WB, //1:Load from memory  0:from ALU
input [15:0] Mem_Out_WB,
input [15:0] Result_WB,
output [15:0] Data_in_WB
);

assign Data_in_WB = (Write_Enable_WB==1'b1)?((Write_Back_Sel_WB==1'b1)?Mem_Out_WB:Result_WB):0;

endmodule
