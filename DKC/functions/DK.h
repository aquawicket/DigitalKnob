#pragma once
#ifndef DK_h
#define DK_h

char* DKSCRIPT_PATH;
char* DKSCRIPT_DIR;
char* DKSCRIPT_FILE;
char* DKSCRIPT_NAME;
char* DKSCRIPT_EXT;
char* DKSCRIPT_ARGS;
char* DKHOME_DIR;
char* DKCACHE_DIR;
char* DKDESKTOP_DIR;
char* DIGITALKNOB;
char* DIGITALKNOB_DIR;
char* DKDOWNLOAD_DIR;
char* DKTOOLS_DIR;
char* DKBRANCH;
char* DKBRANCH_DIR;
char* DK3RDPARTY_DIR;
char* DKAPPS_DIR;
char* DKC_DIR;
char* DKC_FUNCTIONS_DIR;
char* DKC_FUNCTIONS_DIR_;

//################################################################################
//# DK()
//#
#include "dk_preprocessor.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int DK(){
	printf("\x1B[104m \x1B[30m %s %s \x1B[0m \n\n", DKCOMPILER, DKCOMPILER_VERSION);
	
	
	DKHOME_DIR = getenv("USERPROFILE");
	//sprintf(DKCACHE_DIR, "s/.dk");/*, DKHOME_DIR);*/

	//strcat(DKCACHE_DIR, "/.dk");
	//strcat(DKCACHE_DIR, "/.dk");
	
	return 0;
};
int rtn = DK();

#endif //DK_h