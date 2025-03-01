#include "dk_error.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status = 0;
	dk_error("test dk_error()\n");
	dk_error("test dk_error() with number: %d\n", 13);
	dk_error("test dk_error() with string: %s\n", "dk_error");
	return exit_status;
}
#endif
