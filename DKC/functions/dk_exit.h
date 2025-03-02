#pragma once
#ifndef dk_exit_h
#define dk_exit_h

#include "DK.h"


//################################################################################
//# dk_exit()
//#
int dk_exit(int exit_status){
	
	exit(exit_status);
	return exit_status;
};


#endif //dk_exit_h