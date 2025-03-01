#include "dk_info.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_info("test dk_info() \n");
	exit_status = dk_info("test dk_info() with number: %d\n", INFO);
	exit_status = dk_info("test dk_info() with string: %s\n", "INFO string");
	return exit_status;
}
#endif