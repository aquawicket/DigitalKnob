#pragma once
#ifndef dk_callDKVb_h
#define dk_callDKVb_h

#include "DK.h"
#include "dk_echo.h"
#include "dk_exit.h"
#include "dk_error.h"
#include <stdlib.h>
#include <stdio.h>

//####################################################################
//# dk_callDKVb(function, arguments..., rtn_var)
//#
//#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
//#
int dk_callDKVb(char* func, char* args, char* rtn_var){
	dk_echo("%s(%s)\n", func, args);
// main( int argc, char *argv[] )

	char* CMD_EXE = "cmd.exe";
	char* DKSCRIPT_PATH = "C:/Users/Administrator/digitalknob/Development/DKC/functions/dk_callDKVb.h";
	char* DKVB_FUNCTIONS_DIR_ = "C:/Users/Administrator/digitalknob/Development/DKVb/functions/";

	if(-1 == putenv("DKSCRIPT_PATH=C:/Users/Administrator/digitalknob/Development/DKC/functions/dk_callDKVb.h")) {
      dk_error("putenv failed \n");
      return -1;
    }
	if(-1 == putenv("DKVB_FUNCTIONS_DIR_=C:/Users/Administrator/digitalknob/Development/DKVb/functions/")) {
      dk_error("putenv failed \n");
      return -1;
    } 
	
	char* func_path = "C:/Users/Administrator/digitalknob/Development/DKVb/functions/";
	char DKVB_COMMAND[512];
	//int err = sprintf(DKVB_COMMAND, "%s /V:ON /s /c \"(set DKSCRIPT_PATH=%s) & (set DKVB_FUNCTIONS_DIR_=%s) & (set PATH=!DKVB_FUNCTIONS_DIR_!;!PATH!) & echo !PATH! & call %s %s\"", CMD_EXE, DKSCRIPT_PATH, DKVB_FUNCTIONS_DIR_, func, args);
	int err = sprintf(DKVB_COMMAND, "%s /V:ON /s /c \"call %s%s.cmd %s\"",CMD_EXE, DKVB_FUNCTIONS_DIR_, func, args);
    dk_echo("%s\n", DKVB_COMMAND);
	
	FILE *fp;
	char path[1035];

	/* Open the command for reading. */
	//int exit_code = system(DKVB_COMMAND);
	fp = popen(DKVB_COMMAND, "r");
	if (fp == NULL) {
		dk_error("Failed to run command\n" );
		dk_exit(1);
	}

	/* Read the output a line at a time - output it. */
	while (fgets(path, sizeof(path), fp) != NULL) {
		strcpy(rtn_var, path);
		dk_echo("> %s", rtn_var);
	}

	/* close */
	pclose(fp);

	dk_echo("> %s", rtn_var);
	//if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
	return 0;
};


#endif //dk_callDKVb
