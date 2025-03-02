#include "dk_fileWrite.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	
	return dk_fileWrite("C:/DKTest/test.txt", "Write this string to the file\n");
}
#endif
