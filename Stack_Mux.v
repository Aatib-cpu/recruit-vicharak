`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2024 07:04:15 PM
// Design Name: 
// Module Name: Stack_Mux
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

module Branch_Mux(
input Stack_Out_Enable_EX,
input [15:0] Stack_Out_EX,
input [15:0] Immediate_EX,
output [15:0] Branch_Address
);

assign Branch_Address = (Stack_Out_Enable_EX==1'b1)?Stack_Out_EX:Immediate_EX;

/*always@(*) begin
$display("Stack_Out_Enable_EX: %b",Stack_Out_Enable_EX);
$display("Branch_Address: %d",Branch_Address);
$display("Immediate_EX: %d",Immediate_EX);
end*/
endmodule
