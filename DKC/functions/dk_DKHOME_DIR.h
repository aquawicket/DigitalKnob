#pragma once
#ifndef dk_DKHOME_DIR_h
#define dk_DKHOME_DIR_h

#include "DK.h"

char* DKHOME_DIR = "";

//####################################################################
//# dk_DKHOME_DIR()
//#
void dk_DKHOME_DIR(){
    //dk_debugFunc(0, 1);

	//############ SET ############
//	if "%~1" neq "" ( 
//		set "DKHOME_DIR=%~1"
//		%return%
//	)

	//############ GET ############
	// ###### WSLPATH_EXE ######
	// dk_set WSLPATH_EXE   "%WSL_EXE% wslpath"
	// dk_printVar WSLPATH_EXE

	// if not defined HOMEDRIVE    !dk_call! dk_warning "HOMEDRIVE is invalid"
	// if not defined HOMEPATH     !dk_call! dk_warning "HOMEPATH is invalid"
	
	DKHOME_DIR = getenv("USERPROFILE");
//	DKHOME_DIR=%DKHOME_DIR:\=/%"
	
	// if exist "!WSLPATH_EXE!"   !dk_call! dk_commandToVariable "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR

//	dk_assertPath(DKHOME_DIR);
}


#endif //dk_DKHOME_DIR_h