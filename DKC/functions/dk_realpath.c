#include "dk_realpath.h"



//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
int main(int argc, char **argv) {
	
	char* RelPath = "../../../";
	char* AbsPath;
	int rtn_code = dk_realpath(RelPath, &AbsPath);
	printf("AbsPath = %s\n", AbsPath);
	
    return rtn_code;
}
#endif
