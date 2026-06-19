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
	int _dk_delete = remove(path);
    if(_dk_delete == 0){
        dk_success("File deleted successfully.\n");
		exit_status = 0;
    } else {
        dk_error("Error: Unable to delete the file.\n");
		exit_status = 13;
    }
    return exit_status;
};


#endif //dk_delete_h