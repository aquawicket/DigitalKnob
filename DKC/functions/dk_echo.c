#include "dk_echo.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status = 0;
	dk_echo("test dk_echo\n");
	dk_echo("test dk_echo with number: %d\n", 13);
	dk_echo("test dk_echo with string: %s\n", "inserted string");
	return exit_status;
}
#endif
