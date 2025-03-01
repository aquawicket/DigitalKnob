#pragma once
#ifndef dk_createProcess_hpp
#define dk_createProcess_hpp

#include "DK.hpp"

//################################################################################
//# dk_createProcess()
//#
#include "dk_fatal.hpp" 
#include <windows.h>
int dk_createProcess(){
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	char args[512];
 
	//init the STARTUPINFO struct
	memset(&si,0,sizeof(si));
	si.cb=sizeof(si);
 
	//setup the command line arguments
	//sprintf(args,"-f \"C:\\Documents and Settings\\Aeiou\\SERVIDOR\\dirweb\\demo.php\" >\"C:\\Documents and Settings\\Aeiou\\SERVIDOR\\dirtmp\\out00.txt\");
 
	//create the proc with those args
	if(!CreateProcess("C:\\Windows\\System32\\notepad.exe", args, NULL, NULL, 0, 0, NULL, NULL, &si, &pi)) {
		dk_fatal("CreateProcess() failed");
		return 0;
    }
 
	//wait till the proc ends
	//WaitForSingleObject(pi.hProcess,INFINITE);
 
	//close all
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
	return 0;
};

#endif //dk_createProcess_hpp