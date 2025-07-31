///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_testReturn.h"
#include "dk_echo.h"
//#include "dk_replaceAll.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
	//### Result as global variable
	dk_echo("\n");
	dk_testReturn("inputA", NULL);
	dk_echo("testReturn = %s\n", testReturn);
	
	//### Result as parameter
	dk_echo("\n");
	char resultB[256];
	dk_testReturn("inputB", resultB);
	dk_echo("resultB = %s\n", resultB);
	dk_echo("testReturn = %s\n", testReturn);
	
	//### Result as return value
	dk_echo("\n");
	char* resultC;
	resultC=dk_testReturn("inputC", NULL);
	dk_echo("resultC = %s\n", resultC);
	dk_echo("testReturn = %s\n", testReturn);
	
    return 0;
}
#endif
