#pragma once
#ifndef dk_basename_h
#define dk_basename_h

#include "DK.h"
#include "dk_replaceAll.h"
#include <string.h>
#include <stdio.h>
#include <libgen.h>


//################################################################################
//# dk_basename()
//#
int dk_basename(const char* path, char* dk_basename){
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
	
	//###### output ######
	strcpy(dk_basename, base);
	
	return 0;
};

/*
int dk_basename(const char* path){
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
	char* _dk_basename;
	strcpy(_dk_basename, base);
	
	return 0;
};
*/

#endif //dk_basename_h