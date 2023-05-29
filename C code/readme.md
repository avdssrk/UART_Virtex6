# Send data to FPGA from PC
Instead of using **Tera Term** to send the data from the PC to FPGA, we can write a code in **C programming** to send the data serially through the COM port. 

## Serial_Tx_Rx
This program helps to send the data given in the code to the FPGA. 

```
char bytes_to_send[5];
    bytes_to_send[0] = '1';
    bytes_to_send[1] = '2';
    bytes_to_send[2] = '3';
    bytes_to_send[3] = '4';
    bytes_to_send[4] = '5';
    
```

Here we are sending only 5 characters to the FPGA. We can increase them or decrease them. But we can't send a file containing large data. To send the data stored in .txt file, we use another code available.
**NOTE:** If the data is character then, while sending it's equivalent ASCII code is send to the FPGA. If we want to send a number directly, we have to give the number directly as shown below.

```
char bytes_to_send[5];
    bytes_to_send[0] = 1;
    bytes_to_send[1] = 2;
    bytes_to_send[2] = 3;
    bytes_to_send[3] = 4;
    bytes_to_send[4] = 5;
    
```
