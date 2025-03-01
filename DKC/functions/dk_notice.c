#include "dk_notice.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_notice("test dk_notice() \n");
	exit_status = dk_notice("test dk_notice() with number: %d\n", NOTICE);
	exit_status = dk_notice("test dk_notice() with string: %s\n", "NOTICE string");
	return exit_status;
}
#endif