#pragma once
#ifndef dk_callDKBatch_h
#define dk_callDKBatch_h

#include "DK.h"


//####################################################################
//# dk_callDKBatch(function, arguments..., rtn_var)
//#
//#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
//#
#include "dk_echo.h"
#include <stdlib.h>
#include <stdio.h>
void dk_callDKBatch(char* func, char* args, char* rtn_var){
	printf("%s(%s)\n", func, args);
	
	// %dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	char* CMD_EXE = "cmd.exe";
	char* DKSCRIPT_PATH = "C:\\Users\\Administrator\\digitalknob\\Development\\DKC\\functions\\dk_callDKBatch.h";
	char* DKBATCH_FUNCTIONS_DIR_ = "C:\\Users\\Administrator\\digitalknob\\Development\\DKBatch\\functions\\";
	
	//:: Call DKBatch function
	char DKBATCH_COMMAND[512];
	int err = sprintf(DKBATCH_COMMAND, "%s /V:ON /s /c \"(set DKSCRIPT_PATH=%s) & (set DKBATCH_FUNCTIONS_DIR_=%s) & (set PATH=!DKBATCH_FUNCTIONS_DIR_!;!PATH!) & echo !PATH! & call %s %s\"", CMD_EXE, DKSCRIPT_PATH, DKBATCH_FUNCTIONS_DIR_, func, args);
    printf("%s\n", DKBATCH_COMMAND);
	int exit_code = system(DKBATCH_COMMAND);


	//for /f "delims=" %%Z in ('%DKBATCH_COMMAND%') do (
    //    echo %%Z                &rem  Display the other shell's stdout
    //    set "rtn_value=%%Z"     &rem  Set the return value to the last line of output
	//)
    //::echo rtn_value = !rtn_value!
	
	//if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
};


#endif //dk_callDKBatch
