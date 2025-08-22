#pragma once
#ifndef dk_exec_h
#define dk_exec_h

#include "DK.h"



//################################################################################
//# dk_exec()
//#
//#		Reference: https://stackoverflow.com/a/646254/688352
//#		Reference: https://pubs.opengroup.org/onlinepubs/009696799/functions/popen.html
//#
int dk_exec(const char *command){
	//dk_debugFunc(1);
	
	FILE *fp;
	char path[1035];

	/* Open the command for reading. */
	fp = popen(command, "r");
	if (fp == NULL) {
		printf("Failed to run command\n" );
		exit(1);
	}

	/* Read the output a line at a time - output it. */
	while (fgets(path, sizeof(path), fp) != NULL) {
		printf("%s", path);
	}

	/* close */
	pclose(fp);

	return 0;
};


#endif //dk_exec_h