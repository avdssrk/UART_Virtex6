`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:28:20 05/19/2023
// Design Name:   TOP_UART
// Module Name:   C:/Users/Pulak Mondal/Desktop/Shiva/UART_Rx_Tx/test_UART.v
// Project Name:  UART_Rx_Tx
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TOP_UART
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_UART;

	// Inputs
	reg clk=1;
	reg rst=1;
	reg Rx;

	// Outputs
	wire Tx;
	wire [7:0] Rx_Data;

	// Instantiate the Unit Under Test (UUT)
	TOP_UART uut (
		.clk(clk), 
		.rst(rst), 
		.Rx(Rx), 
		.Tx(Tx), 
		.Rx_Data(Rx_Data)
	);

	parameter BAUD_rate = 19200;
	reg [31:0] width = 1_000_000_000/BAUD_rate;
    
	 always #7.5 clk=~clk;
	 
	 initial begin
		  rst=1;
		  Rx=1;
		  #30 rst=0;
		  
		  #(width*2) Rx=0; // start bit
		  #width Rx=0;     //data[0]
		  #width Rx=0;     //data[1]
		  #width Rx=0;     //data[2]
		  #width Rx=0;     //data[3]
		  #width Rx=1;     //data[4]
		  #width Rx=1;     //data[5]
		  #width Rx=0;     //data[6]
		  #width Rx=0;     //data[7]
		  #width Rx=1;     //stop bit
		  
		  #(width*5) Rx=0; // start bit
		  #width Rx=1;     //data[0]
		  #width Rx=1;     //data[1]
		  #width Rx=1;     //data[2]
		  #width Rx=0;     //data[3]
		  #width Rx=0;     //data[4]
		  #width Rx=1;     //data[5]
		  #width Rx=0;     //data[6]
		  #width Rx=0;     //data[7]
		  #width Rx=1;     //stop bit
		  
		  #(width*5) Rx=0; // start bit
		  #width Rx=1;     //data[0]
		  #width Rx=0;     //data[1]
		  #width Rx=0;     //data[2]
		  #width Rx=0;     //data[3]
		  #width Rx=1;     //data[4]
		  #width Rx=1;     //data[5]
		  #width Rx=0;     //data[6]
		  #width Rx=0;     //data[7]
		  #width Rx=1;     //stop bit
		  
   end
      
endmodule

