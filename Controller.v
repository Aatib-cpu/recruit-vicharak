`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2024 05:26:14 PM
// Design Name: 
// Module Name: Controller
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

module Controller(
input [18:0] IR_ID,
output reg [15:0] Immediate_ID,

//RegFile control signals
output reg Read_Enable_1_ID, 
output reg Read_Enable_2_ID,
output reg Write_Enable_ID,

//Stack memory control signals
output reg Stack_In_Enable_ID, 
output reg Stack_Out_Enable_ID, 

//ALU control signal
output reg [1:0] Op1_Sel_ID, 
output reg [1:0] Op2_Sel_ID, 
output reg R_Type_ID,
output reg I_Type_ID,
output reg B_Type_Eq_ID,
output reg B_Type_Neq_ID,
output reg J_Type_ID,
output reg PS_Type_ID,
output [3:0] Func_ID,

//Data-memory control signal
output reg Mem_WR_ID

);

wire [2:0]Opcode_ID;
assign Func_ID = IR_ID[3:0];
assign Opcode_ID = IR_ID[18:16];


always@(IR_ID) begin
R_Type_ID=0; I_Type_ID=0; B_Type_Eq_ID=0; B_Type_Neq_ID=0; J_Type_ID=0; PS_Type_ID=0; Read_Enable_1_ID=0; Read_Enable_2_ID=0; 
Write_Enable_ID=0; Stack_In_Enable_ID=0; Stack_Out_Enable_ID=0; Mem_WR_ID=0;
case(IR_ID[18:16])
3'b000: begin R_Type_ID=1'b1; Immediate_ID=0; Write_Enable_ID=1'b1; Read_Enable_1_ID=1'b1; Read_Enable_2_ID=1'b1; Op1_Sel_ID=2'b01; Op2_Sel_ID=2'b01; 
            if ((IR_ID[3:0]==4'd4)||(IR_ID[3:0]==4'd5)) begin //INC,DEC
                Read_Enable_2_ID = 0; Op2_Sel_ID=2'b10; end
            else if (IR_ID[3:0]==4'd9) begin //NOT
                Read_Enable_2_ID = 0; Op2_Sel_ID = 0; end
            else if ((IR_ID[3:0]==4'd10)||(IR_ID[3:0]==4'd11)||(IR_ID[3:0]==4'd12)) begin //FFT,ENC,DEC
                Read_Enable_1_ID = 0; Op1_Sel_ID = 0; end
            else
                begin Read_Enable_1_ID = 1'b1; Read_Enable_2_ID = 1'b1; Op1_Sel_ID=2'b01; Op2_Sel_ID=2'b01; end
        end
3'b001: begin I_Type_ID=1'b1; Op1_Sel_ID=0; Op2_Sel_ID=0;
            if (IR_ID[0]==1'b1) //Store
            begin Immediate_ID={{8{0}},IR_ID[15:12],IR_ID[7:4]}; Read_Enable_1_ID=1'b1; Mem_WR_ID=1'b1; end 
            else //Load
            begin Immediate_ID={{8{0}},IR_ID[15:8]}; Write_Enable_ID=1'b1; Mem_WR_ID=0; end    
        end
3'b010: begin B_Type_Eq_ID=1'b1; Immediate_ID={{8{0}},IR_ID[7:0]}; Read_Enable_1_ID=1'b1; Read_Enable_2_ID=1'b1; Op1_Sel_ID=2'b01; Op2_Sel_ID=2'b01; end
3'b011: begin B_Type_Neq_ID=1'b1; Immediate_ID={{8{0}},IR_ID[7:0]}; Read_Enable_1_ID=1'b1; Read_Enable_2_ID=1'b1; Op1_Sel_ID=2'b01; Op2_Sel_ID=2'b01; end
3'b100: begin J_Type_ID=1'b1; Immediate_ID={{2{0}},IR_ID[15:2]}; Op1_Sel_ID=0; Op2_Sel_ID=0;
            if (IR_ID[1:0]==2'b01) //CALL
            begin Op1_Sel_ID=2'b10; Op2_Sel_ID=2'b11; Stack_In_Enable_ID=1'b1; end
            else if (IR_ID[1:0]==2'b10) //RET
            Stack_Out_Enable_ID=1'b1;
            else;
         end 
3'b101: begin PS_Type_ID=1'b1; Immediate_ID=0; Read_Enable_1_ID=1'b1; Read_Enable_2_ID=1'b1; Op1_Sel_ID=2'b01; Op2_Sel_ID=2'b01; end
default: Immediate_ID=0;
endcase

//$display("IR_ID = %b", IR_ID);
//$display("Func_ID = %b", IR_ID[3:0]);
//$display("B_Type_Eq_ID = %b", B_Type_Eq_ID);
//$display("B_Type_Neq_ID = %b", B_Type_Neq_ID);
//$display("J_Type_ID = %b", J_Type_ID);
//$display("Immediate_ID = %d", Immediate_ID);
//$display("R_Type_ID = %b", R_Type_ID);
//$display("Op1_Sel_ID = %d", Op1_Sel_ID);
//$display("Op2_Sel_ID = %d", Op2_Sel_ID);
//$display("Mem_WR_ID = %b", Mem_WR_ID);
//$display("Write_Enable_ID = %b", Write_Enable_ID);
end



endmodule