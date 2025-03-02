///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_pathExists.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	char* path = "";
	
	path = "C:/Windows/System32";
	if(dk_pathExists(path) == 0){
		dk_echo("'%s': path exists\n", path);
	} else {
		dk_echo("'%s': path does NOT exist\n", path);
	}
	
	path = "C:/Windows/System32/cmd.exe";
	if(dk_pathExists(path) == 0){
		dk_echo("'%s': path exists\n", path);
	} else {
		dk_echo("'%s': path does NOT exist\n", path);
	}
	
	path = "C:/Non/Existent/Dir";
	if(dk_pathExists(path) == 0){
		dk_echo("'%s': path exists\n", path);
	} else {
		dk_echo("'%s': path does NOT exist\n", path);
	}
	
	int exit_status = 0;
    return exit_status;
}
#endif
