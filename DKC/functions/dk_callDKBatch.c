#include "dk_callDKBatch.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	//dk_debugFunc(0);
	
	char rtn_var[1035] = "undefined";
	int exit_status = dk_callDKBatch("dk_test", "FROM DKBatch", rtn_var);
	dk_echo("rtn_var = %s", rtn_var);
	
	return exit_status;
}
#endif
