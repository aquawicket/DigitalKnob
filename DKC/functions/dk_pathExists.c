#include "dk_pathExists.h"
#include "dk_echo.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	char* path = "";
	
	path = "C:/Windows/System32";
	if(dk_pathExists(path) == 0){
		dk_echo("'%s': path exists\n", path);
	} else {
		dk_echo("'%s': path does NOT exist\n", path);
	}
	
	path = "C:/Windows/System32/cmd.exe";
	if(dk_pathExists(path) == 0){
		dk_echo("'%s': path exists\n", path);
	} else {
		dk_echo("'%s': path does NOT exist\n", path);
	}
	
	path = "C:/Non/Existent/Dir";
	if(dk_pathExists(path) == 0){
		dk_echo("'%s': path exists\n", path);
	} else {
		dk_echo("'%s': path does NOT exist\n", path);
	}
	
	int exit_status = 0;
    return exit_status;
}
#endif
