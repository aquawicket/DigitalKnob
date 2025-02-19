#include "dk_log.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char **argv) {
	
	//dk_log("test dk_log message");
	
	dk_log(VERBOSE, "test dk_log VERBOSE message");
    dk_log(DEBUG,   "test dk_log DEBUG message");
    dk_log(INFO,    "test dk_log INFO message");
    dk_log(SUCCESS, "test dk_log SUCCESS message");
    dk_log(TODO,    "test dk_log TODO message");
    dk_log(NOTICE,  "test dk_log NOTICE message");
    dk_log(FIXME,   "test dk_log FIXME message");
    dk_log(WARNING, "test dk_log WARNING message");
    dk_log(ERROR,   "test dk_log ERROR message");
    dk_log(FATAL,   "test dk_log FATAL message");
	
    return 0;
}
#endif
