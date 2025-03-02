#include "dk_replaceAll.h"



//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	//### output to new varible
	char varA[] = "AZC AZC Zannana Zread";
	dk_echo("varA = %s\n", varA);
	char outputA[256];
	//strcpy(outputA, varA);
    int retA = dk_replaceAll(varA, "Z", "B", outputA);
    dk_echo("outputA = %s\n", outputA);
	//dk_echo("varA = %s\n", varA);
	dk_echo("\n");

	//### output to new varible
	char varB[] = "AZC AZC Zannana Zread";
	dk_echo("varB = %s\n", varB);
	char outputB[256];
	//strcpy(outputB, varB);
    int retB = dk_replaceAll(varB, "Z", "B", outputB);
    dk_echo("outputB = %s\n", outputB);
	//dk_echo("varB = %s\n", varB);
	dk_echo("\n");
	
	//###
    char varC[] = "C:\\path\\with\\backslashes";
    dk_echo("varC = %s\n", varC);
	char outputC[256];
    int retC = dk_replaceAll(varC, "\\", "/", outputC);
    dk_echo("outputC = %s\n", outputC);
	//dk_echo("varC = %s\n", varC);
	dk_echo("\n");
	
	char varD[] = "dk_info('test dk_info message')";
	dk_echo("varD = %s\n", varD);
	char outputD[256];
	dk_replaceAll(varD, "\'", "\"", outputD);
	dk_echo("outputD = %s\n", outputD);
	//dk_echo("varD = %s\n", varD);
	dk_echo("\n");
	
	return retB;
}
#endif
