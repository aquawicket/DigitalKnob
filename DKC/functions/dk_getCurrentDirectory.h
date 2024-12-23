#pragma once
#ifndef dk_getCurrentDirectory_h
#define dk_getCurrentDirectory_h

#include "DK.h"


//################################################################################
//# dk_getCurrentDirectory()
//#
#include <stdio.h>
#include <unistd.h>
void dk_getCurrentDirectory(){
	
	char cwd[1024]; // Buffer to store the current working directory
    if (getcwd(cwd, sizeof(cwd)) != NULL) {
        printf("Current working directory: %s\n", cwd);
    } else {
        perror("getcwd() error");
        return;
    }	
};


#endif //dk_getCurrentDirectory_h