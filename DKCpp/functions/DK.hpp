#pragma once
#ifndef DK_hpp
#define DK_hpp

#include <string>
#include <stdio.h>
#include <iostream>
#include "dk_preprocessor.hpp"


//################################################################################
//# DK()
//#
int DK(){
	printf("\x1B[104m \x1B[30m %s %s \x1B[0m \n\n", DKCOMPILER, DKCOMPILER_VERSION);
	return 0;
};
int rtn = DK();





#endif //DK_hpp