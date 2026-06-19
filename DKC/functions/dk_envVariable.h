#pragma once
#ifndef dk_envVariable_h
#define dk_envVariable_h

#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include "DK.h"
#include "dk_echo.h"
#include "dk_pause.h"


//################################################################################
//# dk_envVariable()
//#
int dk_envVariable(bool _SET_, char* name, char* value){
	
	//###### SET ######
	if(_SET_){
		dk_echo("%s != NULL\n", value);
		char str[50];
		sprintf(str, "%s=%s", name, value);
		dk_echo("putenv(\"%s=%s\")\n", name, value);
		int ret = putenv(str);
		dk_echo("ENV:%s = %s", name, getenv(name));
		return ret;
	}
	
	//###### GET #####
	strcpy(value, getenv(name));
	dk_echo("ENV:%s = %s", name, getenv(name));
	return 0;
};

#endif //dk_envVariable_h
