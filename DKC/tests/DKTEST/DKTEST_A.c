#warning DKTEST_A.c enter
#include "DKTEST_A.h"

#include <stdio.h>
void DKTEST_A(void){ printf("DKTEST_A"); }

#include "DK.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######

int DKTEST(){
	DKTEST_A();
	return 0;
}

#warning DKTEST_A.c exit