#warning DKTEST_B.c enter
#include "DKTEST_B.h"

#include <stdio.h>
void DKTEST_B(void){ printf("DKTEST_B"); }

#include "DK.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
int DKTEST(){
	DKTEST_B();
	return 0;
}

#warning DKTEST_B.c exit
