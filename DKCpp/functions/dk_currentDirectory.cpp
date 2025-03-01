#include "dk_currentDirectory.hpp"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
#include <string>
int main(int argc, char** argv) {
	
	/// Get DKSCRIPT_PATH
	std::string DKSCRIPT_PATH = argv[0];
	std::cout << "DKSCRIPT_PATH: " << DKSCRIPT_PATH.c_str() << "\n";
	
	/// Get current directory
	std::string cwd;
	int exit_status = dk_currentDirectory(cwd);
	std::cout << "Current working directory: " << cwd.c_str() << "\n";
	
    return exit_status;
}
#endif
