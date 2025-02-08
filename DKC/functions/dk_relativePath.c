#include "dk_relativePath.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char **argv) {
	
	char* from = "/C/Users/Administrator/digitalknob";
    char* to = "/C/Users/Administrator/digitalknob/Development/DKC/functions/dk_relativePath.c";

    char* relative_path;
	int rtn_code = dk_relativePath(from, to, &relative_path);
	
#include "dk_echo.h"
    dk_echo("Relative path: %s\n", relative_path);

    //free(relative_path);
    return rtn_code;
}
#endif
