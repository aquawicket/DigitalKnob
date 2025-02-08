///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"
#include "dk_currentDirectory.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char **argv) {
	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	printf("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get current directory
	char* cwd;
	int rtn_code = dk_currentDirectory(&cwd);
	printf("Current working directory: %s\n", cwd);
	
    return rtn_code;
}
#endif
