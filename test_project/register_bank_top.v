`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:05 07/15/2019 
// Design Name: 
// Module Name:    register_bank_top 
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
module register_bank_top(
    output [232:0] a0,
    output [232:0] a1,
    output [232:0] a2,
    output [232:0] a3,
    input c0,
    input c1,
    input clk,
    input [22:0] cword  //from control unit --> c[10:25]&c[30:32] --> register bank.
						// but due to break adding c[26:29] part which was earlier required br quadBlock
								
    );
	 
	wire [3:0] rb_a_addr1, rb_a_addr2, rb_b_addr1, rb_b_addr2, rb_c_addr1, rb_c_addr2; //address each 2
	wire rb_a_we, rb_b_we, rb_c_we; //we
	wire [232:0] rb_a_din, rb_b_din, rb_c_din; //inputs
	wire [232:0] rb_a_out1, rb_a_out2, rb_b_out1, rb_b_out2, rb_c_out1, rb_c_out2;//outputs each 2
	//doubt if this will work;
	wire [232:0] qin, qout;
	wire [3:0] quad_block_sel =  cword[29:26];
	wire [1:0] mux_in3_sel = {cword[32], cword[30]};
	
	mux_2to1 in1(ra_din, cword[14], c0, c1);
	mux_2to1 in2(rb_din, cword[15], c0, c1);
	mux_4to1 in3(rc_din, mux_in3_sel, c0, qout, 233'd0, 233'd1);
	
	dist_RAM_block rb_a(rb_a_out1, rb_a_out2, rb_a_din, rb_a_addr1, rb_a_addr2, rb_a_we, clk);
	dist_RAM_block rb_b(rb_b_out1, rb_b_out2, rb_b_din, rb_b_addr1, rb_b_addr2, rb_b_we, clk);
	dist_RAM_block rb_c(rb_c_out1, rb_c_out2, rb_c_din, rb_c_addr1, rb_c_addr2, rb_c_we, clk);
	
	mux_2to1 out1(a0, cword[11], rb_a_out1, rb_b_out2);
	mux_2to1 out2(a2, cword[12], rb_b_out1, rb_a_out2);
	mux_2to1 out3(a1, cword[13], rb_c_out1, rb_c_out2);
	mux_2to1 out4(qin, cword[21], a2, a1);
	
	quad_block_top qb(qout, qin, quad_block_sel, mux_in3_sel);
endmodule
