`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2024 12:55:26 AM
// Design Name: 
// Module Name: MEM_WB_Reg
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

module MEM_WB_Reg(
input clk,
input reset,
input Write_Back_Sel_Mem,
input Write_Enable_Mem,
input [3:0] rd_Mem,
input [15:0] Mem_Out_Mem, 
input [15:0] Result_Mem,

output reg Write_Back_Sel_WB,
output reg Write_Enable_WB,
output reg [3:0] rd_WB,
output reg [15:0] Mem_Out_WB, 
output reg [15:0] Result_WB
);

always@(posedge clk, posedge reset) begin
if (reset) begin
Write_Back_Sel_WB <= 0;
Write_Enable_WB <= 0;
rd_WB <= 0;
Mem_Out_WB <= 0; 
Result_WB <= 0;
end

else begin
Write_Back_Sel_WB <= Write_Back_Sel_Mem;
Write_Enable_WB <= Write_Enable_Mem;
rd_WB <= rd_Mem;
Mem_Out_WB <= Mem_Out_Mem; 
Result_WB <= Result_Mem;
end
//$display("rd_Mem: %d",rd_Mem);
//$display("rd_WB: %d",rd_WB);
end
endmodule
