#pragma once
#ifndef dk_fileRead_h
#define dk_fileRead_h

#include "DK.h"
#include "dk_echo.h"
#include "dk_error.h"
#include "dk_success.h"


//################################################################################
//# dk_fileRead()
//#
//#		Reference: https://www.geeksforgeeks.org/basics-file-handling-c
//#
int dk_fileRead(const char* filepath, char* contents){
	
	  // Declare the file pointer
    FILE* filePointer;

    // Declare the variable for the data to be read from file
    char dataToBeRead[50];

    // Open the existing file GfgTest.c using fopen() in read mode using "r" attribute
    filePointer = fopen(filepath, "r");

    // Check if this filePointer is null
    // which maybe if the file does not exist
    if (filePointer == NULL) {
        dk_error("failed to open file.");
    }
    else {
        dk_echo("The file is now opened.\n");

        // Read the dataToBeRead from the file
        // using fgets() method
        while (fgets(contents, 50, filePointer) != NULL) {
            dk_echo("%s", contents); // Print the dataToBeRead
        }

        fclose(filePointer); // Closing the file using fclose()

        dk_success("Data successfully read from file\n");
    }
    return 0;
};


#endif //dk_fileRead_h