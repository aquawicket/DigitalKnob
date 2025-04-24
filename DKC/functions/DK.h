#pragma once
#ifndef DK_h
#define DK_h

<<<<<<< HEAD
//#include <cstdio>
#include <string>
#include <stdio.h>
#include <iostream>

/*
#if defined(__GNUC__)
    #if defined(__clang__)
        #define COMPILER_FMT "Clang: %s"
    #else
        #define COMPILER_FMT "GNUC: %s"
    #endif
    #define COMPILER_VERSION __VERSION__
#elif defined(_MSC_VER)
    #define COMPILER_FMT "MSVC: %d"
    #define COMPILER_VERSION _MSC_FULL_VER
#else
    #error Please add your compiler here.
#endif

int main() {
    printf("Built with " COMPILER_FMT "\n", COMPILER_VERSION);
    printf("C++ version: %ld\n", __cplusplus);
}
*/

?/*
//################################################################################
//# DK()
//#
#include <stdio.h>
void DK(){
	printf("DK()\n");
};
*/
=======
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

>>>>>>> Development

#endif //DK_h