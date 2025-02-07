#pragma once
#ifndef dk_pathExists_hpp
#define dk_pathExists_hpp

#include "DK.hpp"


//################################################################################
//# dk_pathExists()
//#
#include <stdio.h>
#include <unistd.h>
int dk_pathExists(const char *dirname) {
	//dk_debugFunc(1);
	
	if(access(dirname, F_OK) == 0) {
        return 1; // Directory exists
    } else {
        return 0; // Directory does not exist
    }
	return 0;
};

#endif //dk_pathExists_hpp