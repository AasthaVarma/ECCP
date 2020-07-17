`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aastha V
// 
// Create Date:    20:54:55 07/15/2019 
// Design Name: 
// Module Name:    hope 
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
`define PX 233'h0fac9dfcbac8313bb2139f1bb755fef65bc391f8b36f8f8eb7371fd558b
`define PY 233'h1006a08a41903350678e58528bebf8a0beff867a7ca36716f7e01f81052
`define B 233'h066647ede6c332c7f8c0923bb58213b333b20e9ce4281fe115f7d8f90ad


module hope(
    output [232:0] x_final,
    output [232:0] y_final,
	 output mul_done,
    input [31:0] key,
    input clk, 
	 input reset
    );

//----A = 1---
//total states = 38 = 3(init) + 4(point_double) 
//		              + 8(point_add) + 24(proj->affine_conv)

parameter Init1=6'd0, Init2=6'd1, Init3=6'd2, //INIT states
			 D1=6'd3, D2=6'd4, D3=6'd5, D4=6'd6,//Point Doubling
			 A1=6'd7, A2=6'd8, A3=6'd9, A4=6'd10, A5=6'd11, A6=6'd12, A7=6'd13, A8=6'd14,//Point Addition
			 I1=6'd15, I2=6'd16, I3=6'd17, I4=6'd18, I5=6'd19, I6=6'd20, I7=6'd21, I8=6'd22, // Proj->Affine conv
			 I9=6'd23, I10=6'd24, I11=6'd25, I12=6'd26, I13=6'd27, I14=6'd28, I15=6'd29, I16=6'd30,
			 I17=6'd31, I18=6'd32, I19=6'd33, I20=6'd34, I21=6'd35, I22=6'd36, I23=6'd37, I24=6'd38;


wire complete;
wire [232:0] py_or_b;
wire [232:0] a0, a1, a2, a3;
wire [232:0] reg_c0, reg_c1, alu_c0, alu_c1;


reg[5:0] state, next_state;
reg [31:0] key_dup;
reg first_one;   // it becomes 1 when forst 1 is found
reg see_first_one; 
reg [9:0] cword_alu;
reg [22:0] cword_reg;

assign py_or_b = (state == I2)? `B : `PY;
assign reg_c0 = (cword_reg[22]==1'b1) ? `PX: alu_c0;
assign reg_c1 = (cword_reg[22]==1'b1) ? py_or_b: alu_c1;

register_bank_top rb(a0, a1, a2, a3, reg_c0, reg_c1, clk, cword_reg);
arithmetic_top alu(alu_c0, alu_c1, a0, a1, a2, a3, cword );

//verify from notes again
// reminder: watch that iitkgp-video lecture once again on fsm
always @(posedge clk) begin
	if(reset == 1'b0)
		state <= Init1;
	else if(start == 1'b0)
		state <= Init2;
	else 
		state <= next_state;
end
// ------------------------
always@(posedge clk) begin
	case(state)
	Init1: next_state <= Init2;
	Init2: next_state <= Init3;
	Init3: next_state <= D1
	D1: next_state <= D2;
	D2: next_state <= D3;
	D3: next_state <= D4;
	D4: begin
		 if(k[31]==1'b1)
			next_state <= A1;
		 else if ( complete == 1'b0)
			next_state <= I1;
		 else
		   next_state <= D4;
	    end
	A1: next_state <= A2;
	A2: next_state <= A3;
	A3: next_state <= A4;
	A4: next_state <= A5;
	A5: next_state <= A6;
	A6: next_state <= A7;
	A7: next_state <= A8;
	A8: begin
	    if(complete==1'b0)
		   next_State <= I1;
		 else
	      next_state <= D1;
	    end
	I1: next_state <= I2;
	I2: next_state <= I3;
	I3: next_state <= I4;
	I4: next_state <= I5;
	I5: next_state <= I6;
	I6: next_state <= I7;
	I7: next_state <= I8;
	I8: next_state <= I9;
	I9: next_state <= I10;
	I10: next_state <= I11;
	I11: next_state <= I12;
	I12: next_state <= I13;
	I13: next_state <= I14;
	I14: next_state <= I15;
	I15: next_state <= I16;
	I16: next_state <= I17;
	I17: next_state <= I18;
	I18: next_state <= I19;
	I19: next_state <= I20;
	I20: next_state <= I21;
	I21: next_state <= I22;
	I22: next_state <= I23;
	I23: next_state <= I24;
	I24: next_state <= I24;
	default: next_state <= Init1;
	endcase
end

always@ (state) begin
	case(state)
		Init1: begin
			  cword_alu      <= 10'b0 ;
			  cword_reg_bank <= 23'h408084 ;
			  end
		Init2: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h40808D ;
			  end
		Init3: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h400098 ;
			  end
		D1: begin
			  cword_alu      <= 10'b1000_001001 ;
			  cword_reg_bank <= 23'h008490 ;
			  end
		D2: begin
			  cword_alu      <= 10'b0000_000010 ;
			  cword_reg_bank <= 23'h0020F0 ;
			  end
		D3: begin
			  cword_alu      <= 10'b1100_100100 ;
			  cword_reg_bank <= 23'h006544 ;
			  end
		D4: begin
			  cword_alu      <= 10'b0011_000000 ;
			  cword_reg_bank <= 23'h000AC0 ;
			  end
		A1: begin
			  cword_alu      <= 10'b0001_001000 ;
			  cword_reg_bank <= 23'h0008A0 ;
			  end
		A2: begin
			  cword_alu      <= 10'b0000_000010 ;
			  cword_reg_bank <= 23'h005006 ;
			  end
		A3: begin
			  cword_alu      <= 10'b0000_101000 ;
			  cword_reg_bank <= 23'h000090 ;
			  end
		A4: begin
			  cword_alu      <= 10'b0000_010001 ;
			  cword_reg_bank <= 23'h000214 ;
			  end
		A5: begin
			  cword_alu      <= 10'b0100_000010 ;
			  cword_reg_bank <= 23'h006544 ;
			  end
		A6: begin
			  cword_alu      <= 10'b0010_001010 ;
			  cword_reg_bank <= 23'h00B4D2 ;
			  end
		A7: begin
			  cword_alu      <= 10'b0000_001011 ;
			  cword_reg_bank <= 23'h0018A2 ;
			  end
		A8: begin
			  cword_alu      <= 10'b0001_011000 ;
			  cword_reg_bank <= 23'h000AC0 ;
			  end
		I1: begin
			  cword_alu      <= 10'b0000_001101 ;
			  cword_reg_bank <= 23'h000400 ;
			  end
		I2: begin
			  cword_alu      <= 10'b0000_000110 ;
			  cword_reg_bank <= 23'h000090 ;
			  end
		I3: begin
			  cword_alu      <= 10'b0000_110101 ;
			  cword_reg_bank <= 23'h000090 ;
			  end
		I4: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h130510 ;
			  end
		I5: begin
			  cword_alu      <= 10'b0000_000010 ;
			  cword_reg_bank <= 23'h000190 ;
			  end
		I6: begin
			  cword_alu      <= 10'b0000_110101 ;
			  cword_reg_bank <= 23'h000090 ;
			  end
		I7: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h170510 ;
			  end
		I8: begin
			  cword_alu      <= 10'b0000_000010 ;
			  cword_reg_bank <= 23'h000190 ;
			  end
		I9: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h1E0510 ;
			  end
		I10: begin
			  cword_alu      <= 10'b0000_000010;
			  cword_reg_bank <= 23'h000190 ;
			  end
		I11: begin
			  cword_alu      <= 10'b0000_110101 ;
			  cword_reg_bank <= 23'h000090 ;
			  end
		I12: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h1E0510 ;
			  end
		I13: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h3E0500 ;
			  end
		I14: begin
			  cword_alu      <= 10'b0000_111010 ;
			  cword_reg_bank <= 23'h000190 ;
			  end
		I15: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h1E0510 ;
			  end
		I16: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h3E0500 ;
			  end
		I17: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h3E0500 ;
			  end
		I18: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h3E0500 ;
			  end
		I19: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h320500 ;
			  end
		I20: begin
			  cword_alu      <= 10'b0000_000010 ;
			  cword_reg_bank <= 23'h000190 ;
			  end
		I21: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h002440 ;
			  end
		I22: begin
			  cword_alu      <= 10'h0 ;
			  cword_reg_bank <= 23'h000004 ;
			  end
		I23: begin
			  cword_alu      <= 10'b0000_001000 ;
			  cword_reg_bank <= 23'h000880 ;
			  end
		I24: begin
			  cword_alu      <= 10'hx ;
			  cword_reg_bank <= 23'h0 ;
			  end
	endcase
end

always @(posedge clk) begin
	if(reset == 1'b0)
			key_dup <= key;
	else if(first_one == 1'b0 or state == D2)
			key_dup[31:0] <={key_dup[30:0], 1'b0};
	else
			key_dup[31:0] <= key_dup[31:0];
end

assign see_first_one = first_one;

always @(posedge clk) begin
	if (reset == 1'b0)
		first_one <= key[31];
	else
		first_one <= see_first_one| key_dup[30];
end

endmodule
