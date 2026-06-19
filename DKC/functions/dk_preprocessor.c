///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_preprocessor.h"

DKMESSAGE(test DKMESSAGE)
DKWARNING(test DKWARNING)
//DKERROR(test DKERROR)

WARNING_DISABLE
#include <stdio.h>
WARNING_ENABLE


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){

#ifdef RTTI_ENABLED
	printf("RTTI_ENABLED = TRUE\n");
#else
	printf("RTTI_ENABLED = FALSE\n");
#endif

#ifdef __has_builtin
	printf("__has_builtin = TRUE\n");
#else
	printf("__has_builtin = FALSE\n");
#endif

#ifdef __has_feature
	printf("__has_feature = TRUE\n");
#else
	printf("__has_feature = FALSE\n");
#endif

#ifdef __has_include
	printf("__has_include = TRUE\n");
#else
	printf("__has_include = FALSE\n");
#endif

	printf("__STDC_VERSION__       = %s \n", __STDC_VERSION__);
	
	printf("DKDATE                 = %s \n", DKDATE);
	printf("DKTIME                 = %s \n", DKTIME);
	printf("DKOS                   = %s \n", DKOS);
	printf("DKOS_VERSION           = %s \n", DKOS_VERSION);
	printf("DKARCH                 = %s \n", DKARCH);
	printf("DKBITS                 = %d \n", DKBITS);
	printf("DKCOMPILER             = %s \n", DKCOMPILER);
	printf("DKCOMPILER_VERSION     = %s \n", DKCOMPILER_VERSION);
	printf("DKC_LANGUAGE_VERSION   = %s \n", DKC_LANGUAGE_VERSION);
	printf("DKCPP_LANGUAGE_VERSION = %s \n", DKCPP_LANGUAGE_VERSION);
	printf("Target_Type            = %s \n", Target_Type);
	
	return 0;
}
#endif