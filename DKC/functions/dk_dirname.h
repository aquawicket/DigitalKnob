#pragma once
#ifndef dk_dirname_h
#define dk_dirname_h

#include "DK.h"
#include "dk_echo.h"

//################################################################################
//# dk_dirname()
//#
#include <stdio.h>
#include <libgen.h>
int dk_dirname(char* path, char* dirname_){
	//dk_debugFunc(1);
	
	char* _dirname_ = dirname(path);
	//dk_echo("_dirname_ = %s\n", _dirname_);
	strcpy(dirname_, _dirname_);
	return 0;
};

#endif //dk_dirname_h