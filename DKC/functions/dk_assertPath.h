#pragma once
#ifndef dk_assertPath_h
#define dk_assertPath_h

#include "DK.h"


//####################################################################
//# dk_assertPath()
//#
#include "dk_pathExists.h"
#include "dk_error.h"
void dk_assertPath(const char* path){
    //dk_debugFunc(1);

	if(dk_pathExists(path)){
		return;
	}
	
	char error_msg[128];
	sprintf(error_msg, "path:'%s' does not exist.\n", path);
	dk_error(error_msg);
}


#endif //dk_assertPath_h