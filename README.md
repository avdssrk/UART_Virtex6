# UART_Virtex6

Implemented UART serial communication protocol with the following parameters:
* Baud rate: 9600,19200,115200
* Number of bits : 8
* Parity bits: 0
* Stop bits : 1

# Brief overview
The UART consisits of Transmitter to serially send the data over the line and a reciever to extract the data from the serial input. A baud rate generator is used to generate the ticks used for sampling. A simplified block diagram of UART looks as shown below:

<p align="center">
  <img src="https://github.com/avdssrk/UART_Virtex6/blob/main/images/block_diag.png" width="440" title="hover text">
</p>

## Baud Rate generator
Generally we need to sample the data, once per data bit. But if we sample it at the starting point, when the data is changing there is a chance of sampling the wrong data before it gets sampled. So we over sample the data. For this we need a clock which is higher than the required frequency. Thumb rule is to use clock 16 time more than the required baud rate. So we use baud rate generator to generate the ticks which is supplied to Tx and Rx.

## Transmitter 
If we want to send a 8bit data 01101011 the signal will be as shown below.

![alt text](https://github.com/avdssrk/UART_Virtex6/blob/main/images/uart.png)

If there is no data in the line, it will be HIGH value in the line. When there is a signal, the signal goes from HIGH to LOW for one period, called as **Start Bit** then, it is followed by the data bit from LSB to MSB. After the MSB, there will be one **stop bit** whose value is 0 for on bit period. Then it will be changed to HIGH.
