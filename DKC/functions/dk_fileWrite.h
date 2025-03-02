#pragma once
#ifndef dk_fileWrite_h
#define dk_fileWrite_h

#include "DK.h"
#include "dk_error.h"
#include "dk_echo.h"
#include "dk_success.h"
#include <stdio.h>
#include <stdlib.h>

//################################################################################
//# dk_fileWrite(filepath, string)
//#
int dk_fileWrite(const char* filepath, const char* str){
	
    // Declare the file pointer
    FILE* filePointer;

    // Get the data to be written in file
	// str

    // Open the existing file using fopen() in write mode using "w" attribute
    filePointer = fopen(filepath, "w");

    // Check if this filePointer is null
    // which maybe if the file does not exist
    if (filePointer == NULL) {
        dk_error("file does not exist\n");
		return -1;
    }
    else {
        dk_success("The file is now opened.\n");

        // Write the dataToBeWritten into the file
        if (strlen(str) > 0) {

            // writing in the file using fputs()
            fputs(str, filePointer);
            fputs("\n", filePointer);
        }

        // Closing the file using fclose()
        fclose(filePointer);

        printf("Data successfully written\n");
    }
    return 0;
};


#endif //dk_fileWrite_h