#include "dk_toUpper.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	char str[] = "AbCdEfGhIjKlMnOp";
	dk_echo("str = %s\n", str);
	dk_toUpper(str);
	dk_echo("str = %s\n", str);
}
#endif
