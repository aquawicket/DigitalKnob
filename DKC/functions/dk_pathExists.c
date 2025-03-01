#include "dk_pathExists.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	if(dk_pathExists("/C/Windows/System32/cmd.exe")){
		dk_echo("'/C/Windows/System32/cmd.exe': path exists\n");
	} else {
		dk_echo("'/C/Windows/System32/cmd.exe': path does NOT exist\n");
	}
	
	if(dk_pathExists("/C/Windows/System32")){
		dk_echo("'/C/Windows/System32'        : path exists\n");
	} else {
		dk_echo("'/C/Windows/System32'        : path does NOT exist\n");
	}
	
	if(dk_pathExists("/C/Non/Existent/Dir")){
		dk_echo("'/C/Non/Existent/Dir'        : path exists\n");
	} else {
		dk_echo("'/C/Non/Existent/Dir'        : path does NOT exist\n");
	}
	
	int exit_status = 0;
    return exit_status;
}
#endif
