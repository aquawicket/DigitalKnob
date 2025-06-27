///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "DK.h"
#include "dk_envVariable.h"
#include <stdlib.h>
#include <stdio.h>


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 
int main(int argc, char** argv){

	dk_echo("main()\n");
	
	int ret = dk_envVariable(0, "TestB", "TestC");
	/*
	char* TestB;
	ret = dk_envVariable(1, "TestB", TestB);
	dk_echo("TestB = %s", TestB);
	
	char* USERPROFILE;
	ret = dk_envVariable(0, "USERPROFILE", USERPROFILE);
	
	dk_echo("USERPROFILE = %s", USERPROFILE);
	*/
	return 0;
}
#endif

