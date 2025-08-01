///$(which true);FLAGS="-g -Wall -Wextra --std=c17 -O1 -fsanitize=address,undefined";THIS_FILE="$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")";OUT_FILE="tmp/build-cache/$THIS_FILE";mkdir -p "$(dirname "$OUT_FILE")";test "$THIS_FILE" -ot "$OUT_FILE" || $(which clang || which gcc) $FLAGS "$THIS_FILE" -o "$OUT_FILE" || exit $?;exec bash -c "exec -a \"$0\" \"$OUT_FILE\" $([ $# -eq 0 ] || printf ' "%s"' "$@")"

#include "dk_replaceAll.hpp"



//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	
	//### replace and output to new varible
	std::string inputA = "AZC AZC Zannana Zread";
	dk_echo("inputA = %s\n", inputA.c_str());
	std::string outputA;
    int returnA = dk_replaceAll(inputA, std::string("Z"), std::string("B"), outputA);
    dk_echo("outputA = %s\n", outputA.c_str());
	dk_echo("\n");
	return returnA;

/*
	//### replace \ slashes with forward / and update original variable
    char varC[] = "C:\\path\\with\\backslashes";
    dk_echo("varC = %s\n", varC);
    int returnC = dk_replaceAll(varC, "\\", "/", varC);
	dk_echo("varC = %s\n", varC);
	dk_echo("\n");
	
	//### replace original with differen size
	char varB[] = "AZC AZC Zannana Zread";
	dk_echo("varB = %s\n", varB);
    int returnB = dk_replaceAll(varB, "Z", "YYY", varB);
	dk_echo("varB = %s\n", varB);
	dk_echo("\n");
	
	return returnB;
*/
}
#endif
