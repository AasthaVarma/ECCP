`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:08:55 07/15/2019 
// Design Name: 
// Module Name:    quad_block_top 
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
module quad_block_top(
    output [232:0] qout,
    input [232:0] qin,
    input [3:0] sel,
    input [1:0] enable
    );

wire [232:0] in_real_quad;

assign in_real_quad = (enable==2'b01) ? qin:233'bx;

quad_block quad(qout, qin, sel);
endmodule
