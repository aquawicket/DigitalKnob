///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"
#include "dk_callDKPowershell.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
void main(){
	//dk_debugFunc(0);
	
	char rtn_var[1035] = "undefined";

	printf("rtn_var = %s", rtn_var);
	dk_callDKPowershell("dk_test", "FROM DKPowershell", rtn_var);
    //dk_echo();
	printf("rtn_var = %s", rtn_var);
}
#endif
