#pragma once
#ifndef dk_pathExists_h
#define dk_pathExists_h

#include "DK.h"


//################################################################################
//# dk_pathExists()
//#
#include <stdio.h>
#include <unistd.h>
int dk_pathExists(const char *dirname) {
	//dk_debugFunc(1);
	
	return access(dirname, F_OK);
};

#endif //dk_pathExists_h