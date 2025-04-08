///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
//int main(int argc, char** argv){
int main(){
	int exit_status = 0;
	
	DK();
	exit_status = dk_echo("test dk_echo() 1\n");
	exit_status = dk_echo("test dk_echo() with number: %d\n", 1);
	exit_status = dk_echo("test dk_echo() with string: %s\n", "dk_echo_1");
	
	exit_status = dk_echo("test dk_echo() 2\n");
	exit_status = dk_echo("test dk_echo() with number: %d\n", 2);
	exit_status = dk_echo("test dk_echo() with string: %s\n", "dk_echo_2");
	
	return exit_status;
}
#endif
