#include "dk_log.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	
	//exit_status = dk_log("test dk_log message");
	exit_status = dk_log(VERBOSE, "test dk_log VERBOSE %d\n");
	exit_status = dk_log(DEBUG,   "test dk_log DEBUG message\n");
    exit_status = dk_log(INFO,    "test dk_log INFO message\n");
    exit_status = dk_log(SUCCESS, "test dk_log SUCCESS message\n");
    exit_status = dk_log(TODO,    "test dk_log TODO message\n");
    exit_status = dk_log(NOTICE,  "test dk_log NOTICE message\n");
    exit_status = dk_log(FIXME,   "test dk_log FIXME message\n");
    exit_status = dk_log(WARNING, "test dk_log WARNING message\n");
    exit_status = dk_log(ERROR,   "test dk_log ERROR message\n");
    exit_status = dk_log(FATAL,   "test dk_log FATAL message\n");
	exit_status = dk_log(INFO,    "test dk_log with number: %d\n", 15);
	exit_status = dk_log(INFO,    "test dk_log with string: %s\n", "inserted string");
    return exit_status;
}
#endif
