#include "dk_debug.hpp"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_debug("test dk_debug() \n");
	exit_status = dk_debug("test dk_debug() with number: %d\n", DEBUG);
	exit_status = dk_debug("test dk_debug() with string: %s\n", "DEBUG string");
	return exit_status;
}
#endif
