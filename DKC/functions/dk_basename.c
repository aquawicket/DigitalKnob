#include "dk_basename.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	/// Get DKSCRIPT_PATH
	const char* DKSCRIPT_PATH = argv[0];
	dk_echo("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get DKSCRIPT_NAME
	char* DKSCRIPT_NAME;
	int exit_status = dk_basename(DKSCRIPT_PATH, DKSCRIPT_NAME);
	dk_echo("DKSCRIPT_NAME = %s\n", DKSCRIPT_NAME);
	
    return exit_status;
}
#endif
