`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2024 02:11:26 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
input clk,
input [15:0] PC_Out,
output reg [18:0] IR_IF
);

reg [7:0]IM[0:60];

//Initializing Instruction Memory 
initial
begin                       //opcode rs2  rs1  rd   func 
    {IM[02],IM[01],IM[00]} = 24'b000_0000_0000_0000_0000_00000; //ADD $0,$0,$0
						    //opcode imm4 rs1  imm4 func    
    {IM[05],IM[04],IM[03]} = 24'b000_0010_0001_0011_0010_00000; //MUL $3,$1,$2
             				//opcode imm4 rs1  imm4 func	
    {IM[08],IM[07],IM[06]} = 24'b000_1100_xxxx_0101_1011_00000; //enc $5,$10 
                            //opcode imm4 imm4 rs1  func                
    {IM[11],IM[10],IM[09]} = 24'b000_0101_xxxx_1111_1100_00000; //dec $15,$5
            				//opcode imm4 imm4 rs1  func	           
    {IM[14],IM[13],IM[12]} = 24'b000_xxxx_0110_0110_0101_00000; //DEC $6,$6 Result: 5  
            				//opcode rs2  rs1  address	          
    {IM[17],IM[16],IM[15]} = 24'b000_0111_0111_0111_0110_00000; //AND $7,$7,$7
                            //opcode rs2  rs1  address               
    {IM[20],IM[19],IM[18]} = 24'b000_1001_1000_1000_0111_00000; //OR $8,$8,$9
    
    {IM[23],IM[22],IM[21]} = 24'b000_1010_1001_1001_1000_00000; //XOR $9,$9,$10 Result: 3 
    
    {IM[26],IM[25],IM[24]} = 24'b000_xxxx_1010_1010_1001_00000; //NOT $10,$10
    
    {IM[29],IM[28],IM[27]} = 24'b000_0000_0000_0000_0000_00000; //ADD r0,r0,r0 
    
    {IM[32],IM[31],IM[30]} = 24'b000_0000_0000_0000_0000_00000; //ADD r0,r0,r0 

    {IM[35],IM[34],IM[33]} = 24'b000_0000_0000_0000_0000_00000; //ADD r0,r0,r0 

    {IM[38],IM[37],IM[36]} = 24'b000_0000_0000_0000_0000_00000; //ADD r0,r0,r0 
     
    {IM[41],IM[40],IM[39]} = 24'b000_0000_0000_0000_0000_00000; //ADD r0,r0,r0

    {IM[44],IM[43],IM[42]} = 24'b000_0000_0000_0000_0000_00000; //ADD r0,r0,r0

    {IM[47],IM[46],IM[45]} = 24'b000_0000_0000_0000_0000_00000; //ADD r0,r0,r0 
end
   
//Asynchronous read operation from Instruction Memory
always@(PC_Out)
begin
IR_IF <= {IM[PC_Out+2],IM[PC_Out+1],{IM[PC_Out][7:5]}};
//$display("IR_IF: %b",IR_IF);
end

endmodule
