#pragma once
#ifndef DK_hpp
#define DK_hpp

#include <string>
#include <stdio.h>
#include <iostream>

// TODO:  each DK.ext file displays the context it's in the version and path to the shell and the DKSCRIPT_PATH
//printf("DK()\n");

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



#endif //DK_hpp