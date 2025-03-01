#include "dk_echoB.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	
	exit_status = DK();
	exit_status = dk_echoB("test dk_echoB() 1\n");
	exit_status = dk_echoB("test dk_echo() with number: %d\n", 1);
	exit_status = dk_echoB("test dk_echoB() with string: %s\n", "dk_echoB_1");
	
	exit_status = dk_echoB("test dk_echoB() 2\n");
	exit_status = dk_echoB("test dk_echoB() with number: %d\n", 2);
	exit_status = dk_echoB("test dk_echoB() with string: %s\n", "dk_echoB_2");
	
	return exit_status;
}
#endif
