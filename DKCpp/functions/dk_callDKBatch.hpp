#pragma once
#ifndef dk_callDKBatch_hpp
#define dk_callDKBatch_hpp

#include "DK.hpp"


//####################################################################
//# dk_callDKBatch(function, arguments..., rtn_var)
//#
//#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
//#
#include "dk_echo.hpp"
#include <stdlib.h>
#include <stdio.h>
int dk_callDKBatch(char* func, char* args, char* rtn_var){
	printf("%s(%s)\n", func, args);

	char* CMD_EXE = "cmd.exe";
	char* DKSCRIPT_PATH = "C:\\Users\\Administrator\\digitalknob\\Development\\DKC\\functions\\dk_callDKBatch.h";
	char* DKBATCH_FUNCTIONS_DIR_ = "C:\\Users\\Administrator\\digitalknob\\Development\\DKBatch\\functions\\";

	char DKBATCH_COMMAND[512];
	int err = sprintf(DKBATCH_COMMAND, "%s /V:ON /s /c \"(set DKSCRIPT_PATH=%s) & (set DKBATCH_FUNCTIONS_DIR_=%s) & (set PATH=!DKBATCH_FUNCTIONS_DIR_!;!PATH!) & echo !PATH! & call %s %s\"", CMD_EXE, DKSCRIPT_PATH, DKBATCH_FUNCTIONS_DIR_, func, args);
    printf("%s\n", DKBATCH_COMMAND);
	
	FILE *fp;
	char path[1035];

	/* Open the command for reading. */
	//int exit_code = system(DKBATCH_COMMAND);
	fp = popen(DKBATCH_COMMAND, "r");
	if (fp == NULL){
		printf("Failed to run command\n");
		exit(1);
	}

	/* Read the output a line at a time - output it. */
	while (fgets(path, sizeof(path), fp) != NULL){
		strcpy(rtn_var, path);
		printf("> %s", rtn_var);
	}

	/* close */
	pclose(fp);

	printf("> %s", rtn_var);
	//if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
	
	int exist_status = 0;
	return exist_status;
};


#endif //dk_callDKBatch_hpp
