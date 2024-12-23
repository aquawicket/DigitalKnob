#pragma once
#ifndef dk_getCurrentDirectory_h
#define dk_getCurrentDirectory_h

#include "DK.h"


//################################################################################
//# dk_getCurrentDirectory()
//#
#include <stdio.h>
#include <unistd.h>
#include <string.h>
int dk_getCurrentDirectory(char** cwdb){
	//dk_debugFunc(1);
	
	char cwd[1024];
    if (getcwd(cwd, sizeof(cwd)) == NULL) {
        perror("getcwd() error");
        return 13;
    }
	
	*cwdb = strdup(cwd);
	return 0;
};

#endif //dk_getCurrentDirectory_h