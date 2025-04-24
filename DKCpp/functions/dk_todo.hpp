#pragma once
#ifndef dk_todo_hpp
#define dk_todo_hpp

#include "DK.hpp"

//################################################################################
//# dk_verbose(message)
//#
#include "dk_log.hpp"
<<<<<<< HEAD
void dk_todo(const char* message){
	dk_log(TODO, message);
=======
int dk_todo(const char* message){
	return dk_log(TODO, message);
>>>>>>> Development
};

#endif //dk_todo_hpp