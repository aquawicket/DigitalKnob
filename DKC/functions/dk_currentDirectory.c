#include "dk_currentDirectory.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	dk_echo("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get current directory
	char* cwd;
	int exit_status = dk_currentDirectory(&cwd);
	dk_echo("Current working directory: %s\n", cwd);
	
    return exit_status;
}
#endif
