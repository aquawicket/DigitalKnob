#include "dk_fatal.hpp"


<<<<<<< HEAD

//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifdef DKTEST
int main() {
	dk_fatal("test dk_fatal()");
    return 0;
=======
//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	return dk_fatal("test dk_fatal()");
>>>>>>> Development
}
#endif
