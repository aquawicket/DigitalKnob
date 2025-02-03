#pragma once
#ifndef dk_currentDirectory_h
#define dk_currentDirectory_h

#include "DK.h"


//################################################################################
//# dk_currentDirectory()
//#
#include <stdio.h>
#include <unistd.h>
#include <string.h>
int dk_currentDirectory(char** cwdb){
	//dk_debugFunc(1);
	
	char cwd[1024];
    if (getcwd(cwd, sizeof(cwd)) == NULL) {
        perror("getcwd() error");
        return 13;
    }
	
	*cwdb = strdup(cwd);
	return 0;
};

#endif //dk_currentDirectory_h