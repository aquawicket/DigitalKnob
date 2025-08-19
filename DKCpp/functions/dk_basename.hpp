#pragma once
#ifndef dk_basename_hpp
#define dk_basename_hpp

#include "DK.hpp"

//################################################################################
char* _dk_basename;   //# Global Return variable

//################################################################################
//# dk_basename(_path, _rtn_var)
//#
//#		Strip directory and suffix from filenames
//#
//#		Reference: https://en.wikipedia.org/wiki/Basename
//#
#include <string.h>
#include <stdio.h>
int dk_basename(char* _path, char** _rtn_var){
	//dk_debugFunc(1);
	
	char *base = strrchr(_path, '/');
    if (base != NULL){
        base++; // Move pointer past the last '/'
    } else {
        base = _path; // If no '/', the entire string is the basename
    }
	*_rtn_var = base;
	_dk_basename = base;
	
	return 0;
};

//################################################################################
//# dk_basename(_path)
//#
//#		Strip directory and suffix from filenames
//#
//#		Reference: https://en.wikipedia.org/wiki/Basename
//#
int dk_basename(char* _path){
	//dk_debugFunc(1);
	
	char *base = strrchr(_path, '/');
    if (base != NULL){
        base++; // Move pointer past the last '/'
    } else {
        base = _path; // If no '/', the entire string is the basename
    }
	_dk_basename = base;
	
	return 0;
};

#endif //dk_basename_hpp