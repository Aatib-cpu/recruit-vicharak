`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2024 07:04:15 PM
// Design Name: 
// Module Name: Operand1_Mux
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

module Operand1_Mux(
    input [1:0] Op1_Sel_EX,
    input [15:0] Rout1,
    input [15:0] PC_EX,
    output reg [15:0] Op1
    );

    always@(*)
    case (Op1_Sel_EX)
    2'b00: Op1 = 0;
    2'b01: Op1 = Rout1;
    2'b10: Op1 = PC_EX;
    default: Op1 = 0;
    endcase
endmodule
