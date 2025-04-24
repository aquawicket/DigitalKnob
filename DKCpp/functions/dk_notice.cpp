#include "dk_notice.hpp"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
<<<<<<< HEAD
#ifdef DKTEST
int main() {
	dk_notice("test dk_notice()");
    return 0;
=======
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	return dk_notice("test dk_notice()");
>>>>>>> Development
}
#endif
