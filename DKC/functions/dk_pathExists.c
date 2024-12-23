#include "dk_pathExists.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
int main(int argc, char **argv) {
	
	if(dk_pathExists("/C/Windows/System32/cmd.exe")){
		printf("path exists\n");
	} else {
		printf("path does NOT exist\n");
	}
	
	if(dk_pathExists("/C/Windows/System32")){
		printf("path exists\n");
	} else {
		printf("path does NOT exist\n");
	}
	
	if(dk_pathExists("/C/Non/Existent/Dir")){
		printf("path exists\n");
	} else {
		printf("path does NOT exist\n");
	}
	
    return 0;
}
#endif
