#include "dk_basename.hpp"
#include "dk_echo.hpp"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){


	//### Result as global variable
	dk_echo("\n");
	char inputA[] = "A:/directoryA/filenameA.extA";
	int exit_statusA = dk_basename(inputA);
	dk_echo("_dk_basename = %s\n", _dk_basename);
	//return exit_statusA;

	//### Result as variable parameter
	dk_echo("\n");
	char inputB[] = "B:/directoryB/filenameB.extB";
	char* resultB;
	int exit_statusB = dk_basename(inputB, &resultB);
	dk_echo("resultB = %s\n", resultB);
	dk_echo("_dk_basename = %s\n", _dk_basename);
	//return exit_statusB;
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

/*	
	/// Get DKSCRIPT_PATH
	char* DKSCRIPT_PATH = argv[0];
	printf("DKSCRIPT_PATH = %s\n", DKSCRIPT_PATH);
	
	/// Get DKSCRIPT_NAME
	char* DKSCRIPT_NAME;
	int exit_status = dk_basename(DKSCRIPT_PATH, &DKSCRIPT_NAME);
	printf("DKSCRIPT_NAME = %s\n", DKSCRIPT_NAME);
*/

	
    return exit_statusA + exit_statusB;
}
#endif
