///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_replaceAll.h"



//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
	//### replace and output to new varible
	char varA[] = "AZC AZC Zannana Zread";
	dk_echo("varA = %s\n", varA);
	char outputA[256];
    int retA = dk_replaceAll(varA, "Z", "B", outputA);
    dk_echo("outputA = %s\n", outputA);
	dk_echo("\n");

	//### replace \ slashes with forward / and update original variable
    char varC[] = "C:\\path\\with\\backslashes";
    dk_echo("varC = %s\n", varC);
    int retC = dk_replaceAll(varC, "\\", "/", varC);
	dk_echo("varC = %s\n", varC);
	dk_echo("\n");
	
	//### replace original with differen size
	char varB[] = "AZC AZC Zannana Zread";
	dk_echo("varB = %s\n", varB);
    int retB = dk_replaceAll(varB, "Z", "YYY", varB);
	dk_echo("varB = %s\n", varB);
	dk_echo("\n");
	
	return retB;
}
#endif
