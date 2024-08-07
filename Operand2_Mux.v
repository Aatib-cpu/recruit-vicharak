`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2024 07:04:15 PM
// Design Name: 
// Module Name: Operand2_Mux
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

module Operand2_Mux(
input [1:0] Op2_Sel_EX,
input [15:0] Rout2,
output reg [15:0] Op2
);

always@(*)
    case (Op2_Sel_EX)
    2'b00: Op2 = 0;
    2'b01: Op2 = Rout2;
    2'b10: Op2 = 1'b1;
    2'b11: Op2 = 16'd3;
    default: Op2 = 0;
    endcase

endmodule
