<<<<<<< HEAD
=======
///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

>>>>>>> Development
#include "dk_log.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
<<<<<<< HEAD
#ifdef DKTEST
int main() {
	
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
=======
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
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
>>>>>>> Development
}
#endif
