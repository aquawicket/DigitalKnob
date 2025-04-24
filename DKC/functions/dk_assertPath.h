#pragma once
#ifndef dk_assertPath_h
#define dk_assertPath_h

#include "DK.h"
#include "dk_pathExists.h"
#include "dk_error.h"

//####################################################################
//# dk_assertPath()
//#
int dk_assertPath(const char* path){
    //dk_debugFunc(1);

	int exit_status = dk_pathExists(path);
	if(exit_status == 0){
		return exit_status;
	}
	
	dk_error("path:'%s' does not exist\n", path);
	return exit_status;
}


#endif //dk_assertPath_h