#include "dk_info.hpp"


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
<<<<<<< HEAD
#ifdef DKTEST
int main() {
	dk_info("test dk_info()");
    return 0;
=======
#ifndef DKMAIN
#define DKMAIN 1
int main(int argc, char** argv){
	return dk_info("test dk_info()");
>>>>>>> Development
}
#endif
