#pragma once
#ifndef dk_pause_h
#define dk_pause_h

#include "DK.h"


//################################################################################
//# dk_pause)
//#
#include "dk_echo.h"
#include <stdio.h>
void dk_pause(){
	dk_echo("press Enter to continue..\n");
	getchar();
};


#endif //dk_pause_h