#include "dk_fatal.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_fatal("test dk_fatal() \n");
	exit_status = dk_fatal("test dk_fatal() with number: %d\n", FATAL);
	exit_status = dk_fatal("test dk_fatal() with string: %s\n", "FATAL string");
	return exit_status;
}
#endif
