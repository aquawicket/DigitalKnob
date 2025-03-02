#pragma once
#ifndef dk_delete_h
#define dk_delete_h

#include "DK.h"
#include <stdio.h>

//################################################################################
//# dk_delete(path)
//#
int dk_delete(const char* path){
	
	// Attempt to delete the file
	int exit_status = remove(path);
    if(exit_status == 0){
        printf("File deleted successfully.\n");
    } else {
        printf("Error: Unable to delete the file.\n");
    }
    return exit_status;
};


#endif //dk_delete_h