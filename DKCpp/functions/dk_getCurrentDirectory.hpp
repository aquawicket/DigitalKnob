#pragma once
#ifndef dk_getCurrentDirectory_hpp
#define dk_getCurrentDirectory_hpp

#include "DK.hpp"


//################################################################################
//# dk_getCurrentDirectory()
//#
#include <filesystem>
#include <iostream>
int dk_getCurrentDirectory(std::string& cwd) {
	//dk_debugFunc();
	
	cwd = std::filesystem::current_path().string();
	return 0;
};


#endif //dk_getCurrentDirectory_hpp