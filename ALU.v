`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2024 07:50:54 PM
// Design Name: 
// Module Name: ALU
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

module ALU(
input R_Type_EX,
input J_Type_EX,
input B_Type_Eq_EX,
input B_Type_Neq_EX,
input [3:0]Func_EX,
input [15:0]Op1,
input [15:0]Op2,
output reg [15:0]Result_EX,
output reg Is_Address_Taken
);


always@(*) begin
Is_Address_Taken=0;  Result_EX=0;
if (R_Type_EX==1'b1) begin //For R Type
case(Func_EX)
4'd0: Result_EX=Op1+Op2; //add
4'd1: Result_EX=Op1-Op2; //sub
4'd2: Result_EX=Op1*Op2; //multiply
4'd3: Result_EX=Op1/Op2; //divide
4'd4: Result_EX=Op1+Op2; //increment
4'd5: Result_EX=Op1-Op2; //decrement
4'd6: Result_EX=Op1&Op2; //and
4'd7: Result_EX=Op1|Op2; //or
4'd8: Result_EX=Op1^Op2; //exor
4'd9: Result_EX=~Op1;    //not
4'd11: Result_EX={Op2[7:6],Op2[3:2],Op2[9:8],Op2[13:12],Op2[1:0],Op2[15:14],Op2[5:4],Op2[11:10]}; //encryption
4'd12: Result_EX={Op2[5:4],Op2[9:8],Op2[1:0],Op2[11:10],Op2[15:14],Op2[3:2],Op2[13:12],Op2[7:6]}; //decryption
default: Result_EX=0;
endcase
end

else if (B_Type_Eq_EX==1'b1) // For B type Equal
Is_Address_Taken = ((Op1==Op2)?1:0);

else if (B_Type_Neq_EX==1'b1) //For B typr Not-Equal
Is_Address_Taken = ((Op1==Op2)?0:1); 

else if ((J_Type_EX==1'b1)) //For J-type
begin Result_EX=Op1+Op2; Is_Address_Taken=1'b1; end

else begin
Result_EX=0; Is_Address_Taken=0;
end
//$display("R_Type_EX: %b",R_Type_EX);
//$display("Func_EX",Func_EX);
//$display("Op1: %d",Op1);
//$display("Op2: %d",Op2);
//$display("Is_Address_Taken: %b",Is_Address_Taken);
//$display("Result_EX: %d",Result_EX);
end

endmodule
