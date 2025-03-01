#include "dk_assertPath.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv) {
	dk_assertPath("/c/Users/Administrator/digitalknob");
	dk_assertPath("C:/Users/Administrator/digitalknob");
	dk_assertPath("C:\\Users\\Administrator\\digitalknob");
	dk_assertPath("C:/NonExistent");
    
	int exit_status = 0;
	return exit_status;
}
#endif
