#pragma once
#ifndef dk_callDKPowershell_h
#define dk_callDKPowershell_h

#include "DK.h"
#include "dk_echo.h"
#include "dk_exit.h"
#include "dk_error.h"
#include <stdlib.h>
#include <stdio.h>

//####################################################################
//# dk_callDKPowershell(function, arguments..., rtn_var)
//#
//#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
//#
int dk_callDKPowershell(char* func, char* args, char* rtn_var){
	//dk_echo("%s(%s)\n", func, args);

	char* POWERSHELL_EXE = "powershell.exe";
	char* DKSCRIPT_PATH = "C:/Users/Administrator/digitalknob/Development/DKC/functions/dk_callDKPowershell.h";
	char* DKPOWERSHELL_FUNCTIONS_DIR = "C:/Users/Administrator/digitalknob/Development/DKPowershell/functions";
	char* DKPOWERSHELL_FUNCTIONS_DIR_ = "C:/Users/Administrator/digitalknob/Development/DKPowershell/functions/";

	if(-1 == putenv("DKSCRIPT_PATH=C:/Users/Administrator/digitalknob/Development/DKC/functions/dk_callDKPowershell.h")) {
      dk_error("putenv failed \n");
      return -1;
    }
	if(-1 == putenv("DKPOWERSHELL_FUNCTIONS_DIR=C:/Users/Administrator/digitalknob/Development/DKPowershell/functions")) {
      dk_error("putenv failed \n");
      return -1;
    } 
	if(-1 == putenv("DKPOWERSHELL_FUNCTIONS_DIR_=C:/Users/Administrator/digitalknob/Development/DKPowershell/functions/")) {
      dk_error("putenv failed \n");
      return -1;
    } 
	
	char DKPOWERSHELL_COMMAND[512];
    //int err = sprintf(DKPOWERSHELL_COMMAND, "%s -Command $global:DKSCRIPT_PATH ^= '%s'^; . %s/%s.ps1^; %s %s", POWERSHELL_EXE, DKSCRIPT_PATH, DKPOWERSHELL_FUNCTIONS_DIR_, func, func, args);
	int err = sprintf(DKPOWERSHELL_COMMAND, "%s -Command . %s%s.ps1^; %s %s", POWERSHELL_EXE, DKPOWERSHELL_FUNCTIONS_DIR_, func, func, args);
	dk_echo("%s\n", DKPOWERSHELL_COMMAND);
	
	FILE *fp;
	char path[1035];

	/* Open the command for reading. */
	fp = popen(DKPOWERSHELL_COMMAND, "r");
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


#endif //dk_callDKPowershell
