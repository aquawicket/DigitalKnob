#pragma once
#ifndef dk_mkdir_h
#define dk_mkdir_h

#include "DK.h"
#include "dk_echo.h"
#include <sys/stat.h>

//################################################################################
//# dk_mkdir()
//#
int dk_mkdir(const char* path){
	
	dk_echo("dk_mkdir(%s)", path);
	return mkdir(path);
};


#endif //dk_mkdir_h