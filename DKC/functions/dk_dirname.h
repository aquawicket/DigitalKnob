#pragma once
#ifndef dk_dirname_h
#define dk_dirname_h

#include "DK.h"


//################################################################################
//# dk_dirname()
//#
#include <stdio.h>
#include <libgen.h>
int dk_dirname(char* path, char** _dirname_){
	//dk_debugFunc(1);
	
	*_dirname_ = dirname(path);
	return 0;
};

#endif //dk_dirname_h