#pragma once
#ifndef dk_todo_h
#define dk_todo_h

#include "DK.h"


//################################################################################
//# dk_todo(str)
//#
#include "dk_log.h"
int dk_todo(const char* str){
	return dk_log(TODO, str);
};


#endif //dk_todo_h