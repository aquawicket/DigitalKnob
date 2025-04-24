///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_dirname.h"
#include "dk_echo.h"
#include "dk_replaceAll.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = (char*)argv[0];
	dk_replaceAll(DKSCRIPT_PATH, "\\", "/", DKSCRIPT_PATH);
	dk_echo("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get DKSCRIPT_DIR
	char* _DKSCRIPT_DIR_;
	int exit_status = dk_dirname(DKSCRIPT_PATH, _DKSCRIPT_DIR_);
	dk_echo("DKSCRIPT_DIR = %s\n", _DKSCRIPT_DIR_);
	
    return exit_status;
}
#endif
