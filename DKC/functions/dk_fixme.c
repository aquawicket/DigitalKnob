#include "dk_fixme.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	exit_status = dk_fixme("test dk_fixme() \n");
	exit_status = dk_fixme("test dk_fixme() with number: %d\n", FIXME);
	exit_status = dk_fixme("test dk_fixme() with string: %s\n", "FIXME string");
	return exit_status;
}
#endif
