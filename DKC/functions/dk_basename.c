///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_basename.h"
#include "dk_echo.h"
#include "dk_replaceAll.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	dk_replaceAll(DKSCRIPT_PATH, "\\", "/", DKSCRIPT_PATH);
	dk_echo("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get DKSCRIPT_NAME
	char* DKSCRIPT_NAME;
	int exit_status = dk_basename(DKSCRIPT_PATH, DKSCRIPT_NAME);
	dk_echo("DKSCRIPT_NAME = %s\n", DKSCRIPT_NAME);
	
    return exit_status;
}
#endif
