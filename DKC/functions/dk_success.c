#include "dk_success.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_success("test dk_success() \n");
	exit_status = dk_success("test dk_success() with number: %d\n", SUCCESS);
	exit_status = dk_success("test dk_success() with string: %s\n", "SUCCESS string");
	return exit_status;
}
#endif
