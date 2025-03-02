#pragma once
#ifndef dk_makeDirectory_h
#define dk_makeDirectory_h

#include "DK.h"
#include "dk_echo.h"
#include <sys/stat.h>

//################################################################################
//# dk_makeDirectory()
//#
int dk_makeDirectory(char* path){
	
	dk_echo("dk_makeDirectory(%s)", path);
	return mkdir(path);
};


#endif //dk_makeDirectory_h