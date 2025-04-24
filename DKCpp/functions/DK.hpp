#pragma once
#ifndef DK_hpp
#define DK_hpp

<<<<<<< HEAD
#include <string>
#include <stdio.h>
#include <iostream>


#define STR(x) #x
#define VERSION(major, minor, patch) STR(major) "." STR(minor) "." STR(patch)
#if __clang__ && __GNUG__
	std::string compiler         = "clang++";
	std::string compiler_version = VERSION(__clang_major__, __clang_minor__, __clang_patchlevel__);
#elif __clang__
	std::string compiler         = "clang";
	std::string compiler_version = VERSION(__clang_major__, __clang_minor__, __clang_patchlevel__);
#elif __llvm__
	std::string compiler         = "llvm";
	std::string compiler_version = STR(__llvm__);
#elif __MINGW64__
	std::string compiler         = "Mingw64";
	std::string compiler_version = VERSION(__MINGW64_VERSION_MAJOR, __MINGW64_VERSION_MINOR, __MINGW64_VERSION_BUGFIX);
#elif __MINGW32__
	std::string compiler         = "Mingw32";
	std::string compiler_version = VERSION(__MINGW32_VERSION_MAJOR, __MINGW32_VERSION_MINOR, __MINGW32_VERSION_BUGFIX);
#elif _MSC_VER	// https://learn.microsoft.com/en-us/cpp/preprocessor/predefined-macros?view=msvc-170
	std::string compiler         = "Microsoft Visual C++"
	std::string compiler_version = STR(_MSC_FULL_VER);
#elif __GNUG__
	std::string compiler         = "GNU G++";
	std::string compiler_version = VERSION(__GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__);
#elif __GNUC__
	std::string compiler         = "GNU GCC";
	std::string compiler_version = VERSION(__GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__);
#else
	std::string compiler         = "UNKNOWN";
	std::string compiler_version = "UNKNOWN";
#endif
=======
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
#include <string>
#include <stdio.h>
#include <iostream>
#include "dk_preprocessor.hpp"
int DK(){
	
	printf("\x1B[104m \x1B[30m %s %s \x1B[0m \n\n", DKCOMPILER, DKCOMPILER_VERSION);
	return 0;
};
int rtn = DK();


>>>>>>> Development



#endif //DK_hpp