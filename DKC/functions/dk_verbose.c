#include "dk_verbose.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_verbose("test dk_verbose() \n");
	exit_status = dk_verbose("test dk_verbose() with number: %d\n", VERBOSE);
	exit_status = dk_verbose("test dk_verbose() with string: %s\n", "VERBOSE string");
	return exit_status;
}
#endif
