`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2024 12:59:20 PM
// Design Name: 
// Module Name: PC_Add_3
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


module PC_Add_3(
input [15:0] PC_Out,
output [15:0] PC_3
);

assign PC_3 = (PC_Out) + 19'd3;

/*always@(*)
$display("PC_3: %d", PC_3);
*/
endmodule
