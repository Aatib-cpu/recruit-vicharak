`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2024 10:36:39 PM
// Design Name: 
// Module Name: ROM
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


module ROM(
input clk, 
input [6:0]address,
output data_out  
);

reg [7:0]ROM[0:2047];

integer i;

initial begin 
$readmemh("test.mem", ROM); 
for (i=0;i<2047;i=i+1)
$display("%d:%h",i,ROM[i]);
end 

assign data_out = ROM[address];
endmodule
