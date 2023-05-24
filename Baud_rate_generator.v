`timescale 1ns / 1ps

module Baud_rate_generator(
    input clk,                           // frequency of FPGA clk
    input rst,                          // reset when signal is 1
    input [21:0] baud_rate,             // baud rate of COM (9600, 19200,115200 etc,.)
    input [4:0] divisions,              // factor to increase the baud rate (8,16)
    output reg en_baud=0 );             // baud rate generation
    
    reg [9:0] counter=1;
    wire [21:0] cycles = 66_000_000/(baud_rate*divisions);
    
    always @(posedge clk)
    begin
        if(rst) begin
                counter<= 1;
                en_baud<=0;
        end
        else if(counter==cycles) begin
            en_baud<=1;
            counter<=1;
        end
        else begin
            counter<=counter+1;
            en_baud<=0;
        end
        
    end 
endmodule
