#pragma once
#ifndef dk_testReturn_hpp
#define dk_testReturn_hpp

#include "DK.hpp"
#include "dk_replaceAll.hpp"

std::string testReturn;
//################################################################################
//# dk_testReturn(input, output)
//#
std::string dk_testReturn(std::string input, std::string& output){
	//dk_debugFunc(1, 2);
	
	dk_replaceAll(input, "input", "output", testReturn);
	//testReturn = input;

	output = testReturn;
	if(output.empty()){
		output = testReturn;
	} else {
		dk_echo("%s\n", testReturn.c_str());
	}
	
	return testReturn;
};

#endif //dk_testReturn_hpp