#include "dk_warning.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_warning("test dk_warning() \n");
	exit_status = dk_warning("test dk_warning() with number: %d\n", WARNING);
	exit_status = dk_warning("test dk_warning() with string: %s\n", "WARNING string");
	return exit_status;
}
#endif
