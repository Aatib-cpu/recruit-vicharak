`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2024 09:40:06 PM
// Design Name: 
// Module Name: Data_Memory
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

module Data_Memory(
input clk,
input reset,
input Mem_Enable,   //I type_Mem
input Mem_WR_Mem,    //Mem Write:1 Read:0
input [3:0] Func_Mem,
input [15:0] Mem_Address_Reg,   //Address_Mem
input [15:0] Mem_Data_Reg,      //Alu_Out_Mem
output reg [15:0] Mem_Out,
output reg Write_Back_Sel_Mem
);

wire [1:0] Variant;
assign Variant = Func_Mem[2:1];
reg [7:0] Mem [0:255];   //256 Byte addressable
integer i;

always@(*) begin
Write_Back_Sel_Mem=0;
if (reset)
	for (i=0;i<255;i=i+1)
		Mem [i] = i;
		
else if ({Mem_Enable,Mem_WR_Mem} == 2'b10)   //memory read
	begin Write_Back_Sel_Mem=1'b1;
	case (Variant)
	    2'b00: Mem_Out = {{8{1'b0}},Mem[Mem_Address_Reg[7:0]]};			                     //lbu
		2'b01: Mem_Out = {{8{Mem[Mem_Address_Reg[7:0]][7]}},Mem[Mem_Address_Reg[7:0]]};  	 //lbs
		2'b10: Mem_Out = {Mem[Mem_Address_Reg[7:0]+1],Mem[Mem_Address_Reg[7:0]]};			 //lw
		default:  Mem_Out = 0;	
	endcase

	end
else
    Mem_Out = 0;
end

always@(posedge clk)
if ({Mem_Enable,Mem_WR_Mem} == 2'b11) //memory write
    case (Variant)
		2'b00: Mem[Mem_Address_Reg[7:0]] = Mem_Data_Reg[7:0];  	//sb
		2'b10: {Mem[Mem_Address_Reg[7:0]+1],Mem[Mem_Address_Reg[7:0]]} = Mem_Data_Reg;	//sw
		//default:  Store_Data = Mem_Data_Reg;
	endcase
else;
	
   /*always@(*)
    begin
    $display("\n Stage 4");
    $display("Mem_Enable: %b",Mem_Enable);
    $display("Mem_WR_ID: %b",Mem_WR_ID);
    $display("Mem_Address_Reg: %d ",Mem_Address_Reg);
    $display("Mem_Data_Reg: %d ",Mem_Data_Reg);
    $display("Mem_Out: %h ",Mem_Out);
    end  */
/*    always@(Mem) 
        for (i=0;i<128;i=i+1) 
            $display("Mem[%0d] = %0d",i,Mem[i]);  //Displaying modified Register File
         */     
    endmodule
