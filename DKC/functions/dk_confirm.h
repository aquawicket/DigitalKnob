#pragma once
#ifndef dk_confirm_h
#define dk_confirm_h

#include "DK.h"
#include "dk_echo.h"
#include "dk_color.h"

//################################################################################
//# dk_confirm()
//#
int dk_confirm(){
	
	char* REPLY;
	dk_echo("%s Are you sure ? [Y/N] %s", yellow, clr);
	scanf("%s", REPLY);
    dk_echo("\n\n");
	
	if(*REPLY == 'Y' || *REPLY == 'y'){
		return 0;
	}
	return 1;
};


#endif //dk_confirm_h