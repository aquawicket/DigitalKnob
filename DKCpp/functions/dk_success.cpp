#include "dk_success.hpp"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
<<<<<<< HEAD
#ifdef DKTEST
int main() {
	dk_success("test dk_success()");
    return 0;
=======
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	return dk_success("test dk_success()");
>>>>>>> Development
}
#endif
