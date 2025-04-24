#pragma once
#ifndef dk_currentDirectory_h
#define dk_currentDirectory_h

#include "DK.h"
#include "dk_replaceAll.h"
#include <stdio.h>
#include <unistd.h>
#include <string.h>

//################################################################################
//# dk_currentDirectory()
//#

int dk_currentDirectory(char* cwdb){
	//dk_debugFunc(1);
	
	//char* cwd;
	char cwd[1024];
	dk_replaceAll(cwdb, "\\", "/", cwd);
    if(getcwd(cwd, sizeof(cwd)) == NULL) {
        perror("getcwd() error");
        return 1;
    }
	
	strcpy(cwdb, strdup(cwd));
	dk_replaceAll(cwdb, "\\", "/", cwdb);
	return 0;
};

#endif //dk_currentDirectory_h