#include "dk_dirname.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
int main(int argc, char **argv) {
	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	printf("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get DKSCRIPT_DIR
	char* DKSCRIPT_DIR;
	int rtn_code = dk_dirname(DKSCRIPT_PATH, &DKSCRIPT_DIR);
	printf("DKSCRIPT_DIR = %s\n", DKSCRIPT_DIR);
	
    return rtn_code;
}
#endif
