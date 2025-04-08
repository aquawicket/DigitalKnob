#pragma once
#ifndef dk_basename_hpp
#define dk_basename_hpp

#include "DK.hpp"


//################################################################################
//# dk_basename()
//#
#include <string.h>
#include <stdio.h>
#include <libgen.h>
int dk_basename(char* path, char** _basename_){
	//dk_debugFunc(1);
	
	// Method 1
//	*_basename_ = basename(path);
	
	// Method 2
	char *base = strrchr(path, '/');
    if (base != NULL){
        base++; // Move pointer past the last '/'
    } else {
        base = path; // If no '/', the entire string is the basename
    }
	*_basename_ = base;
	
	return 0;
};

#endif //dk_basename_hpp