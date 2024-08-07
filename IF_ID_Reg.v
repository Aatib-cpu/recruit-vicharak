`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2024 12:55:26 AM
// Design Name: 
// Module Name: IF_ID_Reg
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


module IF_ID_Reg(
input clk,
input reset,
input [1:0] MUX_IF_PM,
input [15:0] PC_Out,
input [18:0] IR_IF,
output reg [15:0] PC_ID,
output reg [18:0] IR_ID
);

always@(posedge clk, posedge reset) begin
if (reset) begin
PC_ID <= 0;
IR_ID <= 0; end
else begin

case(MUX_IF_PM)//opcode rs2  rs1  rd   func 
2'b01: begin PC_ID <= 0; IR_ID <= 24'b000_0000_0000_0000_0000_00000; end //NOP: ADD r0,r0,r0 
2'b10: begin PC_ID <= PC_ID; IR_ID <= IR_ID;   end//Freeze
default: begin PC_ID <= PC_Out; IR_ID <= IR_IF; end  //Normal 
endcase
end
/*$display("PC_ID: %d", PC_ID);
$display("IR_IF: %b", IR_IF);
$display("IR_ID: %b", IR_ID);*/
end


endmodule
