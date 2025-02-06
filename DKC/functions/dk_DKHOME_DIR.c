#include "dk_DKHOME_DIR.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main() {
	dk_DKHOME_DIR();
	dk_echo(DKHOME_DIR);
    return 0;
}
#endif
