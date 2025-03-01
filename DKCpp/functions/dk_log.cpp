#include "dk_log.hpp"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	int exit_status;
	
	//exit_status = dk_log("test dk_log()");
	exit_status = dk_log(VERBOSE, "test dk_log(VERBOSE)\n");
	exit_status = dk_log(DEBUG,   "test dk_log(DEBUG)\n");
    exit_status = dk_log(INFO,    "test dk_log(INFO)\n");
    exit_status = dk_log(SUCCESS, "test dk_log(SUCCESS)\n");
    exit_status = dk_log(TODO,    "test dk_log(TODO)\n");
    exit_status = dk_log(NOTICE,  "test dk_log(NOTICE)\n");
    exit_status = dk_log(FIXME,   "test dk_log(FIXME)\n");
    exit_status = dk_log(WARNING, "test dk_log(WARNING)\n");
    exit_status = dk_log(ERROR,   "test dk_log(ERROR)\n");
    exit_status = dk_log(FATAL,   "test dk_log(FATAL)\n");
	exit_status = dk_log(INFO,    "test dk_log() with number: %d\n", 15);
	exit_status = dk_log(INFO,    "test dk_log() with string: %s\n", "inserted string");
	
    return exit_status;
}
#endif
