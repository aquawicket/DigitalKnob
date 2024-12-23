#pragma once
#ifndef dk_fileExists_h
#define dk_fileExists_h

#include "DK.h"


//################################################################################
//# dk_fileExists()
//#
#include <stdio.h>
#include <unistd.h>
int dk_fileExists(const char *filename) {
	//dk_debugFunc(1);
	
	 if (access(filename, F_OK) == 0) {
        return 1; // File exists
    } else {
        return 0; // File does not exist
    }
};

#endif //dk_fileExists_h