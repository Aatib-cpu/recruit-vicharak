`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2024 05:26:46 PM
// Design Name: 
// Module Name: Stack_Mem
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

module Stack_Mem(
input clk,
input reset,
input Stack_In_Enable_EX,
input Stack_Out_Enable_EX,
input [15:0]Stack_In_EX,
output reg Empty,
output reg Full,
output reg [15:0]Stack_Out_EX
);

reg [15:0]Stack_Mem [0:15];  //Register file 16 by 16
reg [3:0]Stack_Pointer;

integer i;                      //Index value of Register file

//Initializing Register File 
always@(posedge reset) 
	for (i=0;i<16;i=i+1) begin
	    Stack_Pointer <= 4'd15;
		Stack_Mem[i] <= 0; //Initializing 
		Empty <= 1'b1; 
		Full <= 0;                   
		//$display("Register_Bank[%0d] = %0b",i,i); //Displaying 
		end

		
always@(negedge clk)
    if (Stack_In_Enable_EX && (!Full)) begin
        Stack_Mem[Stack_Pointer] <= Stack_In_EX;      
        Stack_Pointer <= Stack_Pointer-4'd1;
        Empty <= 1'b0; 
        Full <= (Stack_Pointer==4'd0)?1:0;
        end
    else if (Stack_Out_Enable_EX && (!Empty)) begin
        Stack_Out_EX <= Stack_Mem[Stack_Pointer+1];
        Stack_Mem[Stack_Pointer+1]<=0;       
        Stack_Pointer <= Stack_Pointer+4'd1;
        Empty <= (Stack_Pointer==0)?1:0; 
        Full <=  1'b0;
        end
    else
        Stack_Out_EX = 0;   

//Displaying modified Register File 
/*always@(Stack_Mem) begin
    for (i=0;i<16;i=i+1) begin 
		$display("Stack_Mem[%0d] = %0d",i,Stack_Mem[i]);  //Displaying modified Register File
	end 
	$display("Stack_In_Enable_EX: %b",Stack_In_Enable_EX);
	$display("Stack_Out_Enable_EX: %b",Stack_Out_Enable_EX);
	$display("Empty: %b",Empty);
	$display("Full: %b",Full);
	$display("Stack_Pointer: %d",Stack_Pointer);
	$display("Stack_Out_EX: %d",Stack_Out_EX);	                    

end*/
endmodule  
