#include "dk_echo.hpp"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char **argv) {
	return dk_echo(STR(DKCOMPILER DKCOMPILER_VERSION));
}
#endif
