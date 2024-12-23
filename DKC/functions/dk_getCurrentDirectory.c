#include "dk_getCurrentDirectory.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
int main() {
	
	char* cwd;
	int rtn_code = dk_getCurrentDirectory(&cwd);
	
	printf("Current working directory: %s\n", cwd);
	
    return rtn_code;
}
#endif
