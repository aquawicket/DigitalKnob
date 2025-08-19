///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_basename.h"
#include "dk_echo.h"
#include "dk_replaceAll.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){

/*	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	dk_replaceAll(DKSCRIPT_PATH, "\\", "/", DKSCRIPT_PATH);
	dk_echo("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get DKSCRIPT_NAME
	char* DKSCRIPT_NAME;
	int exit_status = dk_basename(DKSCRIPT_PATH, DKSCRIPT_NAME);
	dk_echo("DKSCRIPT_NAME = %s\n", DKSCRIPT_NAME);
*/	
	
/*
	//### Result as global variable
	dk_echo("\n");
	char* _dk_basename;
	char input[] = "A:/directoryA/filenameA.extA";
	int exit_status = dk_basename(input);
	dk_echo("_dk_basename = %s\n", _dk_basename);
*/
	//### Result as variable parameter
	dk_echo("\n");
	char* resultB;
	char input[] = "B:/directoryB/filenameB.extB";
	int exit_status = dk_basename(input, resultB);
	dk_echo("resultB = %s\n", resultB);
/*	
	//### Result as return value
	dk_echo("\n");
	resultC=dk_basename("C:/directoryC/filenameC.extC");
	dk_echo("resultC = ${resultC}");
	//#dk_echo("_dk_basename = ${_dk_basename}");					#NOTE: export cannot be seen outside of command substituion
	
	//### Result as hashtable parameter
	dk_echo("\n");
	dk_echo("\n");
	dk_basename("D:/directoryD/filenameD.extD", resultD[value]);
	dk_echo("resultD[value] = ${resultD[value]}");
	dk_echo("dk_basename = ${dk_basename}");
*/	
	
	
    return exit_status;
}
#endif
