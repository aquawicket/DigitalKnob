#pragma once
#ifndef dk_todo_hpp
#define dk_todo_hpp

#include "DK.hpp"

//################################################################################
//# dk_verbose(message)
//#
#include "dk_log.hpp"
int dk_todo(const char* message){
	return dk_log(TODO, message);
};

#endif //dk_todo_hpp