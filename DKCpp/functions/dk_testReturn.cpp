///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_testReturn.hpp"
#include "dk_echo.hpp"
//#include "dk_replaceAll.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
//	//### Result as global variable
//	dk_call dk_echo
//	dk_call dk_testReturn "inputA";
//	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
//	//### Result as parameter
//	dk_call dk_echo
//	dk_call dk_testReturn "inputB" resultB;
//	dk_call dk_echo "resultB = ${resultB}";
//	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
//	//### Result as return value
//	dk_call dk_echo
//	resultC=$(dk_call dk_testReturn "inputC");
//	dk_call dk_echo "resultC = ${resultC}";
//	#dk_call dk_echo "dk_testReturn = ${dk_testReturn}";					#NOTE: export cannot be seen outside of command substituion
	
    return 0;
}
#endif
