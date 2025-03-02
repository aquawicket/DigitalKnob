#pragma once
#ifndef dk_basename_h
#define dk_basename_h

#include "DK.h"
#include "dk_replaceAll.h"

//################################################################################
//# dk_basename()
//#
#include <string.h>
#include <stdio.h>
#include <libgen.h>
int dk_basename(const char* path, char* _basename_){
	//dk_debugFunc(1);
	
	// Method 1
	//*_basename_ = basename(path);
	
	// Method 2
	char* _path_ = (char *)path;
	dk_replaceAll(_path_, "\\", "/", _path_);
	char *base = strrchr(_path_, '/');
    if (base != NULL) {
        base++; // Move pointer past the last '/'
    } else {
        base = (char*)_path_; // If no '/', the entire string is the basename
    }
	//_basename_ = base;
	strcpy(_basename_, base);
	
	return 0;
};

#endif //dk_basename_h