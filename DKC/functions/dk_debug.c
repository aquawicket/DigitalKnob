#include "dk_debug.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
		
	int exit_status = dk_debug("test dk_debug()");
	return exit_status;
}
#endif
