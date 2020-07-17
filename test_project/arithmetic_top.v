`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:03 07/15/2019 
// Design Name: 
// Module Name:    arithmetic_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module arithmetic_top(
    output [232:0] c0,
    output [232:0] c1,
    input [232:0] a0,
    input [232:0] a1,
    input [232:0] a2,
    input [232:0] a3,
    input [9:0] cword
    );

wire [232:0] a0_sq, a0_p4, a1_sq, a1_p4, a2_sq, a2_p4;  
wire [232:0] a0_a2, a0_p4_a1, a1_sq_a2, a1_a3, a2_sq_a1_a3;
wire [232:0] a2_kmul, a3_kmul, a0_kmul, a2_sq_kmul_a0;

assign a0_a2 = a0 ^ a2;
assign a1_sq_a2 = a1_sq ^ a2;
assign a1_a3 = a1 ^ a3;
assign a2_sq_a1_a3 = a2_sq ^ a1 ^ a3;
assign a2_kmul = a2 ^ kmul;
assign a3_kmul = a3 ^ kmul;
assign a0_kmul = a0 ^ kmul;
assign a2_sq_kmul_a0 = a2_sq ^ kmul ^ a0;
assign a0_p4_a1 = a0_p4 ^ a1;

square aq1(a0_sq, a0);
square sq2(a0_p4, a0_sq);
square sq3(a1_sq, a1);
square sq4(a1_p4, a1_sq);
square sq5(a2_sq, a2);
square sq6(a2_p4, a2_sq);

mux_8to1 mux_a(a_out, cword[2:0], a0, a0_sq, a2, a0_a2, a0_p4_a1, a1, a1_p4);
mux_8to1 mux_b(b_out, cword[5:3], a1, a1_sq, a1_sq_a2, a1_a3, a2_sq_a1_a3, a3, a2_p4, a1_p4);
krtsba_mult_top kmul(kmul_out, a_out, b_out);
mux_4to1 mux_c(c0, c[7:6], kmul_out, a2_kmul, a1_sq, a3_kmul);
mux_4to1 mux_d(c1, c[9:8], a0_kmul, a2_sq_kmul_a0, a1_p4, a0_p4_a1);

endmodule
