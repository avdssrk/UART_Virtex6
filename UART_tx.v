`timescale 1ns / 1ps


module UART_tx(
    input clk,
    input ticks,
    input rst,
    input [7:0] Tx_Data,
    input Tx_en,
    output reg Tx=1,
    output reg Tx_done=0
    );
    
    parameter IDLE = 2'b00, START = 2'b01, DATA=2'b10, STOP = 2'b11;
    parameter rate = 16;
    parameter NBITS = 8;
    reg [1:0] present_state;
    
    
    reg [5:0] counter;
    reg [3:0] bits_count;
    reg [7:0] temp_data;
    
    always @(posedge ticks)
    begin
        case(present_state)
        IDLE: begin
                if(rst) begin
                    present_state<=IDLE;
                    counter<=1;
                    bits_count<=1;
                    temp_data<=0;
                    Tx_done<=0;
                end
                else if(Tx_en) begin
                    present_state<=START;
                    counter<=1;
                    temp_data<=Tx_Data;
                end    
                else
                    present_state<=present_state;
                Tx<=1;
             end
        START: begin
                if(counter==rate) begin
                    present_state<=DATA;
                    counter<=1;
                end
                else begin
                    counter<=counter+1;
                    present_state<=START;
                end  
                Tx<=0;  
            end    
        DATA:   begin
                if(bits_count>NBITS) begin
                    bits_count<=1;
                    counter<=1;
                    present_state<=STOP;
                    end
                else begin
                    if(counter==rate) begin
                         counter<=1;
                         bits_count<=bits_count+1;
                         temp_data<= (temp_data>>1);
                         
                         end
                    else    begin
                         counter<=counter+1;
                     end
                    present_state<=DATA;
							Tx<=temp_data[0];
                end   
                
            end    
        STOP: begin
                if(counter==rate) begin
                    present_state<=IDLE;
                    counter<=1;
                    Tx_done<=0;
                end    
                else begin
                    counter<=counter+1;
                    present_state<=STOP;
                    Tx_done<=1;
                end    
                Tx<=1;
            end    
        default: begin
                    present_state<=IDLE;
                    counter<=1;
                    bits_count<=1;
                end  
        endcase 
    end        
endmodule
