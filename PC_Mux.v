`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2024 12:33:38 AM
// Design Name: 
// Module Name: PC_Mux
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


module PC_Mux(
input Is_Address_Taken,
input [15:0] PC_3,
input [15:0] Branch_Address,
output reg [15:0] PC_In
);

always@(*) begin
if (Is_Address_Taken)
PC_In = Branch_Address;
else
PC_In = PC_3;
//$display("PC_In: %d",PC_In);
end   
    
    
    
endmodule
