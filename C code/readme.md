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

## Serial txt
With this code, we read the data from the .txt file and send it to FPGA. The input file is **mnist_1.txt**. One can change the file name to send the different file.
```
#define MAX_LINE_LENGTH 3138
#define MAX_COLUMNS 785
int main{
    ...
    FILE *file;
    char line[MAX_LINE_LENGTH];
    int data_txt[MAX_COLUMNS];
    int numColumns;
    
    file = fopen("mnist_1.txt", "r");
    ...
}

```
Before running the code, one should take care of the size of the data in the txt file. In this code, the maximum length of the each line & the total number of elements in the txt file is predefined. It should be altered with different files.
