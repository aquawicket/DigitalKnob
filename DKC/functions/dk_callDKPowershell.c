#include "dk_callDKPowershell.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char **argv) {
	//dk_debugFunc(0);
	
	char rtn_var[1035] = "undefined";
	int exit_code = dk_callDKPowershell("dk_test", "FROM DKPowershell", rtn_var);
	dk_echo("rtn_var = %s\n", rtn_var);
	
	return exit_code;
}
#endif
