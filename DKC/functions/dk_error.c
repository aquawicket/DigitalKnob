#include "dk_error.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	int exit_status = dk_error("test dk_error()");
	return exit_status;
}
#endif
