
#include <windows.h>
#include <stdio.h>
#include <time.h>
#include <string.h>

#define MAX_LINE_LENGTH 3138
#define MAX_COLUMNS 785


void pauseS(unsigned int seconds){
    unsigned int msec = seconds*1000;
    clock_t start_time = clock();

    while((clock()-start_time)<msec)
        continue;
}

int main()
{
    int i=0;
    char data[100];
    // Define the five bytes to send ("hello")
    char bytes_to_send[5];
    bytes_to_send[0] = '1';
    bytes_to_send[1] = '2';
    bytes_to_send[2] = '3';
    bytes_to_send[3] = '4';
    bytes_to_send[4] = '5';

    // reading the data from the .txt file

    FILE *file;
    char line[MAX_LINE_LENGTH];
    int data_txt[MAX_COLUMNS];
    int numColumns;

    file = fopen("mnist_1.txt", "r");
    if (file == NULL) {
        printf("Error opening the file.\n");
        return 1;
    }

    while (fgets(line, sizeof(line), file) != NULL) {
        numColumns = 0;
        char *token = strtok(line, "\t"); // Split line by tab space

        while (token != NULL && numColumns < MAX_COLUMNS) {
            data_txt[numColumns] = atoi(token); // Convert token to integer
            numColumns++;
            token = strtok(NULL, "\t");
        }
    }

    fclose(file);




    // Declare variables and structures
    HANDLE hSerial;
    DCB dcbSerialParams = {0};
    COMMTIMEOUTS timeouts = {0};
    DWORD bytesRead;
    // Open the highest available serial port number
    fprintf(stderr, "Opening serial port...");
    hSerial = CreateFile(
                "\COM4", GENERIC_READ|GENERIC_WRITE, 0, NULL,
                OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL );
    if (hSerial == INVALID_HANDLE_VALUE)
    {
            fprintf(stderr, "Error\n");
            return 1;
    }
    else fprintf(stderr, "OK\n");

    // Set device parameters (38400 baud, 1 start bit,
    // 1 stop bit, no parity)
    dcbSerialParams.DCBlength = sizeof(dcbSerialParams);
    if (GetCommState(hSerial, &dcbSerialParams) == 0)
    {
        fprintf(stderr, "Error getting device state\n");
        CloseHandle(hSerial);
        return 1;
    }

    dcbSerialParams.BaudRate = CBR_115200;
    dcbSerialParams.ByteSize = 8;
    dcbSerialParams.StopBits = ONESTOPBIT;
    dcbSerialParams.Parity = NOPARITY;
    if(SetCommState(hSerial, &dcbSerialParams) == 0)
    {
        fprintf(stderr, "Error setting device parameters\n");
        CloseHandle(hSerial);
        return 1;
    }

    // Set COM port timeout settings
    timeouts.ReadIntervalTimeout = 50;
    timeouts.ReadTotalTimeoutConstant = 50;
    timeouts.ReadTotalTimeoutMultiplier = 10;
    timeouts.WriteTotalTimeoutConstant = 50;
    timeouts.WriteTotalTimeoutMultiplier = 10;
    if(SetCommTimeouts(hSerial, &timeouts) == 0)
    {
        fprintf(stderr, "Error setting timeouts\n");
        CloseHandle(hSerial);
        return 1;
    }

    // Send specified text (remaining command line arguments)
    DWORD bytes_written, total_bytes_written = 0;
    fprintf(stderr, "Sending bytes...");
    for(i=0;i<numColumns;i++){
        if(!WriteFile(hSerial, data_txt+i, 1, &bytes_written, NULL))
        {
            fprintf(stderr, "Error\n");
            CloseHandle(hSerial);
            return 1;
        }
        if (!ReadFile(hSerial, data, sizeof(data) - 1, &bytesRead, NULL)) {
            fprintf(stderr, "Error reading from serial port\n");
            CloseHandle(hSerial);
            return 1;
        }

        data[bytesRead] = '\0';
        printf("Received data: %s\n", data);
        //Sleep(100);
        pauseS(1);
    }
    fprintf(stderr, "%d bytes written\n", bytes_written);

    // Close serial port
    fprintf(stderr, "Closing serial port...");
    if (CloseHandle(hSerial) == 0)
    {
        fprintf(stderr, "Error\n");
        return 1;
    }
    fprintf(stderr, "OK\n");

    // exit normally
    return 0;
}
