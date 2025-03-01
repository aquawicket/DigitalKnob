#include "dk_confirm.h"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	if(dk_confirm() == 0){
		dk_echo("the confimation has passed");
	} else {
		dk_echo("the confimation has failed");
	}
}
#endif
