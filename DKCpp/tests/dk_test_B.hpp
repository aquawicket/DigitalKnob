#pragma once
#ifndef dk_test_B_hpp
#define dk_test_B_hpp

#include "DK.hpp"

//################################################################################
//# dk_test_B(args)
//#
#include "dk_log.hpp"
std::string& dk_test_B(std::string& args){
	
	args = std::string("altered content");
	return args;
};

#endif //dk_test_B_hpp