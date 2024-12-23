#include "dk_basename.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
int main(int argc, char **argv) {
	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	printf("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get DKSCRIPT_NAME
	char* DKSCRIPT_NAME;
	int rtn_code = dk_basename(DKSCRIPT_PATH, &DKSCRIPT_NAME);
	printf("DKSCRIPT_NAME = %s\n", DKSCRIPT_NAME);
	
    return rtn_code;
}
#endif
