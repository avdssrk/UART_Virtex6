# UART_Virtex6

Implemented UART serial communication protocol with the following parameters:
* Baud rate: 9600,19200,115200
* Number of bits : 8
* Parity bits: 0
* Stop bits : 1

# Brief overview

If we want to send a 8bit data 01101011 the signal will be as shown below.
![alt text](https://github.com/avdssrk/UART_Virtex6/blob/main/images/uart.png)

If there is no data in the line, it will be HIGH value in the line. When there is a signal, the signal goes from HIGH to LOW for one period, called as **Start Bit** then, it is followed by the data bit from LSB to MSB. After the MSB, there will be one **stop bit** whose value is 0 for on bit period. Then it will be changed to HIGH.
