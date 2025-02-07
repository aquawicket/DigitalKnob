#pragma once
#ifndef dk_assertPath_hpp
#define dk_assertPath_hpp

#include "DK.hpp"


//####################################################################
//# dk_assertPath()
//#
#include "dk_pathExists.hpp"
#include "dk_error.hpp"
void dk_assertPath(const char* path){
    //dk_debugFunc(1);

	if(dk_pathExists(path)){
		return;
	}
	
	char error_msg[128];
	sprintf(error_msg, "path:'%s' does not exist.\n", path);
	dk_error(error_msg);
}


#endif //dk_assertPath_hpp