#include "dk_fileExists.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
int main(int argc, char **argv) {
	
	if(dk_fileExists("/C/Windows/System32/cmd.exe")){
		printf("file exists\n");
	} else {
		printf("file does NOT exist\n");
	}
	
	if(dk_fileExists("/C/Non/Existent/File")){
		printf("file exists\n");
	} else {
		printf("file does NOT exist\n");
	}
	
    return 0;
}
#endif
