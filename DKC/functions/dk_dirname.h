#pragma once
#ifndef dk_dirname_h
#define dk_dirname_h

#include "DK.h"
#include "dk_echo.h"
#include <stdio.h>
#include <libgen.h>

//################################################################################
//# dk_dirname(path, output)
//#
int dk_dirname(const char* path, char* output){
	//dk_debugFunc(1);
	
	dk_echo("dk_dirname(%s)\n", path);
	char* _dirname_ = dirname((char*)path);
	dk_echo("_dirname_ = %s\n", _dirname_);
	strcpy(output, _dirname_);
	return 0;
};

#endif //dk_dirname_h