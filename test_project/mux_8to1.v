`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:48:19 07/15/2019 
// Design Name: 
// Module Name:    mux_8to1 
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
module mux_8to1(
    output [232:0] q,
    input [2:0] sel,
    input [232:0] i0,
    input [232:0] i1,
    input [232:0] i2,
    input [232:0] i3,
    input [232:0] i4,
    input [232:0] i5,
    input [232:0] i6,
    input [232:0] i7
    );

always @(*) begin
	case(sel)
	3'd0: q = i0;
	3'd1: q = i1;
	3'd2: q = i2; 
	3'd3: q = i3;
	3'd4: q = i4;
	3'd5: q = i5;
	3'd6: q = i6;
	3'd7: q = i7;
	default: q = 233'd0;
	endcase
end
endmodule
