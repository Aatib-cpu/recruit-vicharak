`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2024 09:48:30 PM
// Design Name: 
// Module Name: Reg_File
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

module Reg_File(
input clk,
input reset,
input [15:0] Data_in_WB,
input [18:0] IR_ID, 
input Write_Enable_WB,
input [3:0]rd_WB,
input Read_Enable_1_ID,
input Read_Enable_2_ID,
output [3:0] rd_ID,
output [3:0] rs1_ID,
output [3:0] rs2_ID,
output reg [15:0] Rout1_ID,
output reg [15:0] Rout2_ID
);


assign rs2_ID=IR_ID[15:12];
assign rs1_ID=IR_ID[11:8];
assign rd_ID=IR_ID[7:4];

reg [15:0] Register_Bank [0:15];//Register file 16 by 16
integer i;                      //Index value of Register file

//Initializing Register File 
always@(posedge reset) 
	for (i=0;i<16;i=i+1) begin
		Register_Bank [i] <= i;                    //Initializing Register File with its Index Value
		//$display("Register_Bank[%0d] = %0b",i,i); //Displaying Register File 
		end

//Writing Data in Register File 		
always@(negedge clk)
    if (Write_Enable_WB)
        Register_Bank[rd_WB] <= Data_in_WB;      //Initializing Register File with its Index Value

//Reading Data from Register File 
always@(IR_ID, Read_Enable_1_ID, Read_Enable_2_ID, Register_Bank) begin
    if (Read_Enable_1_ID==1'b1)
        Rout1_ID = Register_Bank[rs1_ID];      //Reading Value at rs from Register File
    else
        Rout1_ID = 0;   

    if (Read_Enable_2_ID==1'b1)
        Rout2_ID = Register_Bank[rs2_ID];      //Reading Value at rt from Register File
    else
        Rout2_ID = 0;    
end     

//Displaying modified Register File 
/*always@(Register_Bank) 
    for (i=0;i<16;i=i+1) begin
		$display("Register_Bank[%0d] = %0d",i,Register_Bank[i]);  //Displaying modified Register File 
		end*/                     

/*always@(IR_ID) begin
$display("IR_ID = %b", IR_ID);
$display("rs1_ID = %b", rs1_ID);
$display("rs2_ID = %b", rs2_ID);
$display("rd_ID = %b", rd_ID);
$display("Read_Enable_1_ID = %b", Read_Enable_1_ID);
$display("Read_Enable_2_ID = %b", Read_Enable_2_ID);
$display("Write_Enable_WB = %b", Write_Enable_WB);
$display("Rout1_ID = %d", Rout1_ID);
$display("Rout2_ID = %d", Rout2_ID);
end*/
endmodule
