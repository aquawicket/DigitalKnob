#pragma once
#ifndef DK_h
#define DK_h


//################################################################################
//# DK()
//#
#include "DKPreprocessor.h"
#include <stdio.h>
int DK(){
	printf("\x1B[104m \x1B[30m %s %s \x1B[0m \n\n", DKCOMPILER, DKCOMPILER_VERSION);
	return 0;
};


int rtn = DK();

#endif //DK_h