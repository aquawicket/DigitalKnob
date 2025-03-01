#include "dk_realpath.h"
#include "dk_echo.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	char* RelPath = "../../../";
	char* AbsPath;
	int exit_status = dk_realpath(RelPath, &AbsPath);
	
	dk_echo("AbsPath = %s\n", AbsPath);
	
    return exit_status;
}
#endif
