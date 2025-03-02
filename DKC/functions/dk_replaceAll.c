#include "dk_replaceAll.h"



//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
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
