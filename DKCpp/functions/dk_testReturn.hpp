#pragma once
#ifndef dk_testReturn_hpp
#define dk_testReturn_hpp

#include "DK.hpp"
#include "dk_replaceAll.hpp"

std::string testReturn;
//################################################################################
//# dk_testReturn(input)
//#
std::string dk_testReturn(std::string input){
	//dk_debugFunc(1);
	
	dk_replaceAll(input, "input", "output", testReturn);
	dk_echo("%s\n", testReturn.c_str());
	return testReturn;
};

//################################################################################
//# dk_testReturn(input, output)
//#
std::string dk_testReturn(std::string input, std::string& output){
	//dk_debugFunc(2);
	
	dk_replaceAll(input, "input", "output", testReturn);
	output = testReturn;
	return testReturn;
};

#endif //dk_testReturn_hpp