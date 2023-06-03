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

# Baud Rate generator
Generally we need to sample the data, once per data bit. But if we sample it at the starting point, when the data is changing there is a chance of sampling the wrong data before it gets sampled. So we over sample the data. For this we need a clock which is higher than the required frequency. Thumb rule is to use clock 16 time more than the required baud rate. So we use baud rate generator to generate the ticks which is supplied to Tx and Rx.

<p align="center">
  <img src="https://github.com/avdssrk/UART_Virtex6/blob/main/images/uart_baud.png" width="1150" title="baud_rate_gen">
</p>


If we are using 9600 buad rate and 16x method, then the required frequency of the output should be 9600x16= 153600 pulses per second. But in case of Virtex-6 ML605 board the available clock is 66MHz. So we use counter to generate the pulses. The mod of the counter is 66M/(9600x16) = 429.6875. Approximately we use Mod-430 counter. When the count==430(starting with count=1), the output of baud rate generator will be HIGH. In this way we generate the pulses which are applied to the Tx and Rx modules.

<p align="center">
  <img src="https://github.com/avdssrk/UART_Virtex6/blob/main/images/clk_gen.png" width="1150" title="baud_rate_input_clk">
</p>

**Note:** The output should not the square wave 'clock' waveform which is 16 times the baud rate. 

 
<p align="center">
  <img src="https://github.com/avdssrk/UART_Virtex6/blob/main/images/baud_block.png" width="800" title="baud_rate_block_diagram">
</p>

# Transmitter 
If we want to send a 8bit data 01101011 the signal will be as shown below.

![UART_signal](https://github.com/avdssrk/UART_Virtex6/blob/main/images/uart_sig.png)

If there is no data in the line, it will be HIGH value in the line. When there is a signal, the signal goes from HIGH to LOW for one period, called as **Start Bit** then, it is followed by the data bit from LSB to MSB. After the MSB, there will be one **stop bit** whose value is 0 for on bit period. Then it will be changed to HIGH.

# Receiver 
To avoid the false sampling the sample the data at the middle of the data. So we sample at the 8th clock pulse generated from the baud rate generator. 

<p align="center">
  <img src="https://github.com/avdssrk/UART_Virtex6/blob/main/images/uartx.png" width="1150" title="Reciever">
</p>

Based on this idea, we develop a state machine to sample the data the required points and not sample when there is no information(HIGH). 

# Tools used
To send the data serially from PC to FPGA through COM port, we used **Tera Term** tool. Initially we need to select the COM port. Install the required USB-UART drivers for the ports. In this case I am using the **Silicon Labs CP210x USB to UART Bridge driver**. You can download it from the website.

<p align="center">
  <img src="https://github.com/avdssrk/UART_Virtex6/blob/main/images/tera1.png" width="1000" title="tera term 1">
</p>

Make sure the parameters are same as you designed on FPGA. The parameters can be changed from the Options as shown below. Go to **Setup>Serial Port..** then change the parameters.

<p align="center">
  <img src="https://github.com/avdssrk/UART_Virtex6/blob/main/images/tera2.png" width="800" title="tera term 1">
</p>
