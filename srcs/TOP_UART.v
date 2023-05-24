`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:46 05/19/2023 
// Design Name: 
// Module Name:    TOP_UART 
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
module TOP_UART(input clk,
					input rst,
					input Rx,
					output Tx,
					output [7:0] Rx_Data);
	
	parameter [21:0] baud_rate=19200;
   parameter [4:0] divisions =16;
    
    
    wire ticks;
	 wire Tx_en;
	 wire Tx_done;
    
    Baud_rate_generator buad_en_16_x(clk,rst,baud_rate,divisions,ticks);
    UART_rx uart_rx(Rx,rst,clk,ticks,Rx_Data,Tx_en);
	 UART_tx uart_tx(clk,ticks,rst,Rx_Data,Tx_en,Tx,Tx_done);


endmodule
