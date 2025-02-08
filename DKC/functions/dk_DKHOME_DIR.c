#include "dk_DKHOME_DIR.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main() {
	int rtn_code = dk_DKHOME_DIR();
	dk_echo(DKHOME_DIR);
    return rtn_code;
}
#endif
