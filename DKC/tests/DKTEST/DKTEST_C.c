#warning DKTEST_C.c enter
#include "DKTEST_C.h"

#include <stdio.h>
void DKTEST_C(void){ printf("DKTEST_C"); }

#include "DK.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
int DKTEST(){
	DKTEST_C();
	return 0;
}

#warning DKTEST_C.c exit
