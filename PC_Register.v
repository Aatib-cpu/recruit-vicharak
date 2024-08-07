`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2024 10:43:10 AM
// Design Name: 
// Module Name: PC_Register
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


module PC_Register(
input clk,reset,Do_Stall,
input [15:0] PC_In,
output reg [15:0] PC_Out
); 
  
always @(posedge clk, posedge reset) begin
    if (reset)
        PC_Out <= 16'h0000;
    else if (Do_Stall)
        PC_Out <= PC_Out;
    else
        PC_Out <= PC_In;
//$display("PC_Out: %d",PC_Out);
end           
endmodule