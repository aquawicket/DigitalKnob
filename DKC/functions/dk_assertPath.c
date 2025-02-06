#include "dk_assertPath.h"

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main() {
	dk_assertPath("/c/Users/Administrator/digitalknob");
	dk_assertPath("C:/Users/Administrator/digitalknob");
	dk_assertPath("C:\\Users\\Administrator\\digitalknob");
	dk_assertPath("C:/NonExistent");
    return 0;
}
#endif
