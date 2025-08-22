///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_testReturn.h"
#include "dk_echo.h"
#include "dk_exec.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
	//### Result as global variable
	dk_echo("\n");
	dk_testReturn("inputA", NULL);
	dk_echo("_dk_testReturn = %s\n", _dk_testReturn);
	
	//### Result as parameter
	dk_echo("\n");
	char resultB[256];
	dk_testReturn("inputB", resultB);
	dk_echo("resultB = %s\n", resultB);
	dk_echo("_dk_testReturn = %s\n", _dk_testReturn);
	
	//### Result as return value
	dk_echo("\n");
	char* resultC = dk_testReturn("inputC", NULL);
	dk_echo("resultC = %s\n", resultC);
	dk_echo("_dk_testReturn = %s\n", _dk_testReturn);
	
	//### Result as return value and parameter variable 	[GLOBAL][PARAM][RETURN]
	dk_echo("\n");
	char resultD[256];
	char* resultE=dk_testReturn("inputDE", resultD);
	dk_echo("resultD = %s\n", resultD);
	dk_echo("resultE = %s\n", resultE);
	dk_echo("_dk_testReturn = %s\n", _dk_testReturn);
	
	//### Result from stdout								[STDOUT]
	dk_echo("\n");
	//$resultF = "";
	//$exit_code = -1;
	//putenv("DKTEST=OFF");
	dk_exec("C:/Users/Administrator/DigitalKnob/Development/DKC/functions/build/dk_basename.exe C:/Windows/System32");//, resultF, exit_code);
	//dk_echo("resultF = %s\n", resultF);
	//dk_echo("exit_code = $exit_code\n");
	
    return exit_status;
}
#endif
