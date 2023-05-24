`timescale 1ns / 1ps

module UART_rx(
    input Rx,
    input rst,
    input clk,
    input ticks,
    output [7:0] Rx_Data,
	 output reg Rx_done=0
    );
    
    parameter start_ticks = 8;
    parameter data_ticks = 16;
    parameter stop_ticks=16;
    parameter bits = 8;
    
    parameter IDLE = 2'b00, START = 2'b01, DATA=2'b10, STOP = 2'b11;
    
    reg [1:0] present_state=2'b00;
    
    reg [3:0] start_counter=1;
    reg [4:0] stop_counter;
    reg [4:0] data_counter;
    reg [3:0] bits_counter;
    reg [7:0] Data=0;
    //reg Rx_done=0;
    
    // state machine for state change only
    always @ (posedge ticks)
    begin
        if(rst) begin
            present_state<=IDLE;
        end
		  else
				present_state<=present_state;
    
        case(present_state)
        IDLE: begin
                
                if(Rx==0) begin
                    present_state<=START;
                    start_counter<=1;
                end
                else begin
                    present_state<=IDLE;
                end     
            end 
        START: begin  
                if(Rx==0 && start_counter==(start_ticks)) begin
                    start_counter<=1;
                    present_state<=DATA;
                    data_counter<=1;
                    bits_counter<=1;
                end
                else if(Rx==1 && start_counter<(start_ticks)) begin
                    start_counter<=1;
                    present_state<=IDLE;
                end
                else begin
                    start_counter<=start_counter+1;
                    present_state<=START;
                end
             end        
        DATA: begin
                if(bits_counter>bits) begin
                    bits_counter<=1;
                    present_state <=STOP;
                    data_counter<=1;
                    stop_counter<=1;
                    Rx_done<=1;
                end
                else begin
                    if(data_counter==(data_ticks)) begin
                        Data[bits_counter-1] <= Rx;
                        data_counter<=1;
                        bits_counter <=bits_counter+1;
                    end
                    else begin
                        data_counter<=data_counter+1;
                    end
                    present_state<=DATA;
                end
            end
        STOP: begin
                if(stop_counter== stop_ticks) begin
                    present_state<=IDLE;
                    stop_counter<=1;
                    Rx_done<=0;
                    
                end
                else begin
                    present_state<=STOP;
                    stop_counter<=stop_counter+1;
                end    
            end
                          
        default: begin
                present_state<=IDLE;
                start_counter<=1;
                stop_counter<=1;
                data_counter<=1;
                end
        endcase 
     end     
     
     assign Rx_Data = Rx_done?Data:Rx_Data;
        
endmodule
