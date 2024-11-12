#pragma once
#ifndef dk_todo_hpp
#define dk_todo_hpp

#include "DK.hpp"

//################################################################################
//# dk_verbose(message)
//#
#include "dk_log.hpp"
void dk_todo(const char* message){
	dk_log(TODO, message);
};

#endif //dk_todo_hpp