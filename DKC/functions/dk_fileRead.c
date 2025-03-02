#include "dk_fileRead.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	char* fileContents;
	return dk_fileRead("C:/DKTest/test.txt", fileContents);
	dk_echo("%s", fileContents);
}
#endif
