#include "dk_pathExists.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char **argv) {
	
	if(dk_pathExists("/C/Windows/System32/cmd.exe")){
		printf("'/C/Windows/System32/cmd.exe': path exists\n");
	} else {
		printf("'/C/Windows/System32/cmd.exe': path does NOT exist\n");
	}
	
	if(dk_pathExists("/C/Windows/System32")){
		printf("'/C/Windows/System32'        : path exists\n");
	} else {
		printf("'/C/Windows/System32'        : path does NOT exist\n");
	}
	
	if(dk_pathExists("/C/Non/Existent/Dir")){
		printf("'/C/Non/Existent/Dir'        : path exists\n");
	} else {
		printf("'/C/Non/Existent/Dir'        : path does NOT exist\n");
	}
	
    return 0;
}
#endif
