#pragma once
#ifndef dk_notice_h
#define dk_notice_h

#include "DK.h"


//################################################################################
//# dk_notice(str)
//#
#include "dk_log.h"
int dk_notice(const char* str){
	return dk_log(NOTICE, str);
};


#endif //dk_notice_h