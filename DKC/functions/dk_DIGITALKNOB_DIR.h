#pragma once
#ifndef dk_DIGITALKNOB_DIR_h
#define dk_DIGITALKNOB_DIR_h

#include "DK.h"


//char* DIGITALKNOB_DIR;

//################################################################################
//# dk_DIGITALKNOB_DIR(str)
//#
#include "dk_DKHOME_DIR.h"
int dk_DIGITALKNOB_DIR(){
	
	dk_DKHOME_DIR();
	char temp[1028];
	DIGITALKNOB_DIR = temp;
	sprintf(DIGITALKNOB_DIR, "%s/digitalknob", DKHOME_DIR);
	

	return 0;
};


#endif //dk_DIGITALKNOB_DIR_h