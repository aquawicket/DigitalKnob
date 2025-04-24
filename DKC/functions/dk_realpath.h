#pragma once
#ifndef dk_realpath_h
#define dk_realpath_h

#define PATH_MAX 256

#include "DK.h"


//################################################################################
//# dk_realpath()
//#
#include <stdio.h>
#include <libgen.h>
#include <string.h>
int dk_realpath(char* relative_path, char** _realpath_){
	//dk_debugFunc(1);
	
    char absolute_path[PATH_MAX];

    if (realpath(relative_path, absolute_path) == NULL) {
        perror("realpath");
        return 1;
    }
 	
	*_realpath_ = strdup(absolute_path);
	return 0;
};

#endif //dk_realpath_h