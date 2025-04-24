#pragma once
#ifndef dk_callDKBash_h
#define dk_callDKBash_h

#include <stdlib.h>
#include <stdio.h>
#include "DK.h"
#include "dk_echo.h"
#include "dk_error.h"
#include "dk_exit.h"


//####################################################################
//# dk_callDKBash(function, arguments..., rtn_var)
//#
//#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
//#
int dk_callDKBash(char* func, char* args, char* rtn_var) {
	
	dk_echo("dk_callDKBash(%s(%s))\n", func, args);

//	//set "USE_WSL=1"
//	if(USE_WSL == 1){
//		dk_validate(DKIMPORTS_DIR, dk_DKIMPORTS_DIR());
//		dk_validate(WSL_EXE, "%DKIMPORTS_DIR%/wsl/dk_install.cmd");
//	}

//	//### Get DKHTTP_DKBASH_FUNCTIONS_DIR
//	if not defined DKHTTP_DKBASH_DIR            (set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash")
//	if not defined DKHTTP_DKBASH_FUNCTIONS_DIR  (set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions")
	
//	::### Download files if missing
//	if not exist %DKBASH_FUNCTIONS_DIR%/DK.sh	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh")
//	if not exist %DKBASH_FUNCTIONS_DIR%/%~1.sh	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/%~1.sh" "%DKBASH_FUNCTIONS_DIR%/%~1.sh")
	
//	dk_validate BASH_EXE "dk_BASH_EXE"
	
//	set ALL_BUT_FIRST=%*
//	if defined ALL_BUT_FIRST (set ALL_BUT_FIRST=!ALL_BUT_FIRST:*%1=!)
	
//  // get LAST_ARG
//	for %%a in (%*) do set LAST_ARG=%%a
	
//	::set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
//    set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
//	if defined USE_WSL (set "DKSCRIPT_PATH=%DKSCRIPT_PATH:/c/=/mnt/c/%")

//	::set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:\=/%"
//    set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:C:=/c%"
//	if defined USE_WSL (set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:/c/=/mnt/c/%")	
//    set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR%/"

//  set "RELOAD_WITH_BASH=0"
//  if defined USE_WSL (set WSLENV=DKSCRIPT_PATH/u:DKINIT/u:RELOAD_WITH_BASH/u:DKBASH_FUNCTIONS_DIR_/u)

	char* BASH_EXE = "C:/Users/Administrator/digitalknob/DKTools/git-portable-2.46.2-64-bit/bin/bash.exe";
	char* DKSCRIPT_PATH = "C:/Users/Administrator/digitalknob/Development/DKC/functions/dk_callDKBash.h";
	char* DKBASH_FUNCTIONS_DIR_ = "/C/Users/Administrator/digitalknob/Development/DKBash/functions/";

	
	if(-1 == putenv("DKSCRIPT_PATH=C:/Users/Administrator/digitalknob/Development/DKC/functions/dk_callDKBash.h")) {
      dk_error("putenv failed \n");
      return -1;
    } 
	if(-1 == putenv("DKBASH_FUNCTIONS_DIR_=/C/Users/Administrator/digitalknob/Development/DKBash/functions/")) {
      dk_error("putenv failed \n");
      return -1;
    }
	
	char DKBASH_COMMAND[1028];
	int err = sprintf(DKBASH_COMMAND, "%s -c '. %s%s.sh; %s %s'", BASH_EXE, DKBASH_FUNCTIONS_DIR_, func, func, args);
	dk_echo("DKBASJH_COMMAND = %s", DKBASH_COMMAND);
	
	FILE *fp;
	char path[1035];

	/* Open the command for reading. */
	//int exit_code = system(DKBASH_COMMAND);
	fp = popen(DKBASH_COMMAND, "r");
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


#endif //dk_callDKBash
