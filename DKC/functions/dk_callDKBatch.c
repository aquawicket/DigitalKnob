#include "dk_callDKBatch.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
void main(){
	//dk_debugFunc(0);
	
	char* rtn_var;
	dk_callDKBatch("dk_test", "FROM DKBatch", rtn_var);
    //dk_echo();
	//dk_echo("rtn_var = "+rtn_var.c_str());
}
#endif
