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
	
	return access(dirname, F_OK);
};

#endif //dk_pathExists_hpp