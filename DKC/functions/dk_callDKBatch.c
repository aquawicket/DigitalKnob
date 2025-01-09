#include "dk_callDKBatch.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
void main(){
	//dk_debugFunc(0);
	
	char rtn_var[1035] = "undefined";

	printf("rtn_var = %s", rtn_var);
	dk_callDKBatch("dk_test", "FROM DKBatch", rtn_var);
    //dk_echo();
	printf("rtn_var = %s", rtn_var);
}
#endif
