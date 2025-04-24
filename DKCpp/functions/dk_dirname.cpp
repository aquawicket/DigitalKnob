#include "dk_dirname.hpp"
#include "dk_echo.hpp"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	dk_echo("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get DKSCRIPT_DIR
	char* DKSCRIPT_DIR;
	int exit_status = dk_dirname(DKSCRIPT_PATH, &DKSCRIPT_DIR);
	dk_echo("DKSCRIPT_DIR = %s\n", DKSCRIPT_DIR);
	
    return exit_status;
}
#endif
