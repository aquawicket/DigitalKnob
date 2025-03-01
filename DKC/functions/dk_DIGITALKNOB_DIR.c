#include "dk_DIGITALKNOB_DIR.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	int exit_status = dk_DIGITALKNOB_DIR();
	dk_echo(DIGITALKNOB_DIR);
    return exit_status;
}
#endif
