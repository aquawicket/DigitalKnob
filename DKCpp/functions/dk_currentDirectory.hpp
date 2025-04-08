#pragma once
#ifndef dk_currentDirectory_hpp
#define dk_currentDirectory_hpp

#include "DK.hpp"


//################################################################################
//# dk_currentDirectory()
//#
#include <filesystem>
#include <iostream>
int dk_currentDirectory(std::string& cwd){
	//dk_debugFunc();
	
	cwd = std::filesystem::current_path().string();
	return 0;
};


#endif //dk_currentDirectory_hpp