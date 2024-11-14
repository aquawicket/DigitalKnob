#pragma once
#ifndef dk_test_hpp
#define dk_test_hpp

#include "DK.hpp"

//################################################################################
//# dk_test(args)
//#
#include "dk_log.hpp"
std::string& dk_test(std::string& args){
	
	args = std::string("altered content");
	return args;
};

#endif //dk_test_hpp