#pragma once
#ifndef dk_getCurrentDirectory_hpp
#define dk_getCurrentDirectory_hpp

#include "DK.hpp"


//################################################################################
//# dk_getCurrentDirectory()
//#
#include <filesystem>
#include <iostream>
void dk_getCurrentDirectory(){
	std::filesystem::path currentDirectory = std::filesystem::current_path();
	printf("currentDirectory = %s", currentDirectory.string().c_str());
};


#endif //dk_getCurrentDirectory_hpp