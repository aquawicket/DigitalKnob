#include "dk_getCurrentDirectory.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char **argv) {
	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	printf("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get current directory
	char* cwd;
	int rtn_code = dk_getCurrentDirectory(&cwd);
	printf("Current working directory: %s\n", cwd);
	
    return rtn_code;
}
#endif
