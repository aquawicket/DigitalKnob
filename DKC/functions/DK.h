#pragma once
#ifndef DK_h
#define DK_h

int DK_C = 0;
int exit_status;
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
char* DKCPP_APPS_DIR;
char* DKC_DIR;
char* DKC_FUNCTIONS_DIR;
char* DKC_FUNCTIONS_DIR_;

//################################################################################
//# DK()
//#
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "dk_preprocessor.h"
#include "dk_echo.h"
//#include "dk_DKHOME_DIR.h"
//#include "dk_DIGITALKNOB_DIR.h"

int DK() {
	dk_echo("\x1B[104m \x1B[30m - %s %s \x1B[0m \n\n", DKCOMPILER, DKCOMPILER_VERSION);
	return 0;
}


#endif //DK_h