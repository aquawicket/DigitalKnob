#include "dk_warning.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	int exit_status = dk_warning("test dk_warning()");
	return exit_status;
}
#endif
