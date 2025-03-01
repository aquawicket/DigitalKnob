#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	
	exit_status = dk_echo("test dk_echo() 1\n");
	exit_status = dk_echo("test dk_echo() with number: %d\n", 1);
	exit_status = dk_echo("test dk_echo() with string: %s\n", "dk_echo_1");
	
	exit_status = dk_echo("test dk_echo() 2\n");
	exit_status = dk_echo("test dk_echo() with number: %d\n", 2);
	exit_status = dk_echo("test dk_echo() with string: %s\n", "dk_echo_2");
	
	return exit_status;
}
#endif
