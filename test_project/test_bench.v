`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:35:09 07/15/2019
// Design Name:   test
// Module Name:   C:/Users/user/Desktop/DesktopContents/drdo/test_project/test_bench.v
// Project Name:  test_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench;

	// Inputs
	reg [2:0] a;

	// Outputs
	wire [1:0] d;

	// Instantiate the Unit Under Test (UUT)
	test uut (
		.d(d), 
		.a(a)
	);

	initial begin
		// Initialize Inputs
		a = 3'b010;

		// Wait 100 ns for global reset to finish
		#100;
        
		a = 3'b101;
		// Add stimulus here

	end
      
endmodule

