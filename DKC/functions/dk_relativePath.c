#include "dk_relativePath.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char **argv) {
	
	char* from = "/C/Users/Administrator/digitalknob";
    char* to = "/C/Users/Administrator/digitalknob/Development/DKC/functions/dk_relativePath.c";

    char* relative_path = dk_relativePath(from, to);
    printf("Relative path: %s\n", relative_path);

    free(relative_path);
    return 0;
}
#endif
