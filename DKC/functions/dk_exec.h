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
int dk_exec(const char *command, char* output){
	//dk_debugFunc(1);
	
	FILE *fp;
	char out[1035];

	/* Open the command for reading. */
	fp = popen(command, "r");
	if (fp == NULL) {
		printf("Failed to run command\n" );
		exit(1);
	}

	/* Read the output a line at a time - output it. */
	while (fgets(out, sizeof(out), fp) != NULL) {
		//printf("%s", out);
	}

	strcpy(output, out);
	
	/* close */
	pclose(fp);

	return 0;
};


#endif //dk_exec_h