#pragma once
#ifndef dk_fixme_h
#define dk_fixme_h

#include "DK.h"


//################################################################################
//# dk_fixme(str)
//#
#include "dk_log.h"
int dk_fixme(const char* str, ...){
	return dk_log(FIXME, str);
};


#endif //dk_fixme_h