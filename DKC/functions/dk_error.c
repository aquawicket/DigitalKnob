#include "dk_error.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_error("test dk_error() \n");
	exit_status = dk_error("test dk_error() with number: %d\n", ERROR);
	exit_status = dk_error("test dk_error() with string: %s\n", "ERROR string");
	return exit_status;
}
#endif
