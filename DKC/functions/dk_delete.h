#pragma once
#ifndef dk_delete_h
#define dk_delete_h

#include "DK.h"
#include "dk_success.h"
#include "dk_error.h"
#include <stdio.h>

//################################################################################
//# dk_delete(path)
//#
int dk_delete(const char* path){
	
	// Attempt to delete the file
	int exit_status = remove(path);
    if(exit_status == 0){
        dk_success("File deleted successfully.\n");
    } else {
        dk_error("Error: Unable to delete the file.\n");
    }
    return exit_status;
};


#endif //dk_delete_h